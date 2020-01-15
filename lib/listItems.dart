import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'db.dart';

class ListState extends StatefulWidget {
  @override
  ListItems createState() => ListItems();
}

class ListItems extends State<ListState> {
  bool _switchValue;

  @override
  void initState() {
    super.initState();
    this._switchValue = false;
  }

  int id;
  TextEditingController myTitleController = TextEditingController();
  TextEditingController myDescriptionController = TextEditingController();

  createAlertDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Center(
              child: Text(
                'Update Item',
                style: TextStyle(
                  fontSize: 25.0,
                ),
              ),
            ),
            content: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    width: 500.0,
                    child: TextField(
                      controller: myTitleController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue))),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20.0),
                    child: TextField(
                      maxLines: 8,
                      controller: myDescriptionController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue))),
                    ),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              MaterialButton(
                child: Text(
                  'Cancel',
                  style: TextStyle(fontSize: 18.0, color: Colors.blue),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child: OutlineButton(
                    child: Text('Submit',
                        style: TextStyle(color: Colors.blue, fontSize: 18.0)),
                    onPressed: () async {
                      var item = ToDoItem(
                          id: id,
                          title: myTitleController.text,
                          description: myDescriptionController.text);
                      await DatabaseConnection.db.upDateToDoItem(item);
                      setState(() {
                        this._switchValue = true;
                      });
                      Navigator.of(context).pop();
                    },
                    borderSide: BorderSide(
                      color: Colors.blue,
                    ),
                  )),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To Do Items'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<ToDoItem>>(
          future: DatabaseConnection.db.getToDoItems(),
          builder:
              (BuildContext context, AsyncSnapshot<List<ToDoItem>> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  ToDoItem item = snapshot.data[index];

                  return Padding(
                      padding: EdgeInsets.only(
                          bottom: 10.0, left: 10.0, right: 10.0),
                      child: Card(
                        child: Column(
                          children: <Widget>[
                            ListTile(
                              title: Padding(
                                padding: EdgeInsets.only(bottom: 20.0),
                                child: Center(
                                  child: Text(
                                    item.title,
                                    style: TextStyle(
                                        fontSize: 25.0,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                              subtitle: Text(
                                item.description,
                                style: TextStyle(fontSize: 20.0),
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.all(20.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    InkWell(
                                      onTap: () {
                                        id = item.id;
                                        myTitleController.text = item.title;
                                        myDescriptionController.text =
                                            item.description;
                                        createAlertDialog(context);
                                      },
                                      child: Text(
                                        'UPDATE',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            color: Colors.blue,
                                            fontSize: 18.0),
                                      ),
                                    ),
                                    OutlineButton(
                                        color: Colors.blue,
                                        child: Text(
                                          'Delete',
                                          style: TextStyle(
                                              color: Colors.blue,
                                              fontSize: 18.0),
                                        ),
                                        borderSide: BorderSide(
                                          color: Colors.blue,
                                        ),
                                        onPressed: () async {
                                          await DatabaseConnection.db
                                              .deleteToDOItem(item.id);
                                          setState(() {
                                            this._switchValue = true;
                                          });
                                        }),
                                  ],
                                ))
                          ],
                        ),
                      ));
                },
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
