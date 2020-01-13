import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'db.dart';

class ListItems extends StatelessWidget {
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
                            )
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
