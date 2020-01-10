import 'dart:math';
import 'package:flutter/material.dart';

import 'package:flutter_to_do/db.dart';


class Home extends StatelessWidget {
  String title = '';
  String itemDescription = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('To Do App'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 50.0),
                child: TextField(
                  onChanged: (text) {
                    title = text;
                  },
                  textCapitalization: TextCapitalization.sentences,
                  style: TextStyle(fontSize: 27.0),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue)),
                      labelText: 'Add Title',
                      hintStyle: TextStyle(fontSize: 27.0)),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 40.0),
                child: TextField(
                  onChanged: (text) {
                    itemDescription = text;
                  },
                  maxLines: 8,
                  style: TextStyle(fontSize: 20.0),
                  textCapitalization: TextCapitalization.sentences,
                  textInputAction: TextInputAction.send,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue)),
                      labelText: 'To do item',
                      hintStyle: TextStyle(fontSize: 20.0)),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 60.0),
                child: SizedBox(
                    width: 365.0,
                    height:70.0,
                    child: RaisedButton(
                  onPressed: () async {
                    var randomId = new Random();
                    var item = ToDoItem(id: randomId.nextInt(100), title: title, description: itemDescription);
                    await DatabaseConnection.db.insertItem(item);
                  },
                  color: Colors.blue,
                  child: Text(
                    'Save',
                    style: TextStyle(color: Colors.white),
                  ),
                )),
              ),
            ]),
      ),
    );
  }
}
