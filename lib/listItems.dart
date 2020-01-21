import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/todolist_bloc.dart';
import 'bloc/todolist_event.dart';
import 'bloc/todolist_state.dart';
import 'db.dart';

class ListState extends StatefulWidget {
  @override
  ListItems createState() => ListItems();
}

class ListItems extends State<ListState> {
  bool _switchValue;

  TodolistBloc toDoItemBloc = TodolistBloc();

  @override
  void initState() {
    super.initState();
    this._switchValue = false;
    toDoItemBloc.add(GetToDoList());
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

                      toDoItemBloc.add(UpdateToDoList(item));
                      toDoItemBloc.add(GetToDoList());
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
        body: Container(
          child: BlocBuilder(
              bloc: toDoItemBloc,
              builder: (BuildContext context, TodolistState state) {
                if (state is GetTodolistState) {
                  return ListView.builder(
                    itemCount: state.items.length,
                    itemBuilder: (BuildContext context, int index) {
                      ToDoItem item = state.items[index];

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
                                              toDoItemBloc
                                                  .add(DeleteToDoList(item.id));
                                              toDoItemBloc.add(GetToDoList());
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
        ));
  }

  @override
  void dispose() {
    super.dispose();
  }
}
