import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_to_do/db.dart';
import './bloc.dart';

class TodolistBloc extends Bloc<TodolistEvent, TodolistState> {
  @override
  TodolistState get initialState => LoadingToDoListState();

  @override
  Stream<TodolistState> mapEventToState(
    TodolistEvent event,
  ) async* {
    
    if(event is GetToDoList) {
      yield* _mapGetToDoItems();
    } else if(event is DeleteToDoList) {
      yield* _mapDeleteToDoItems(event);
    } else  if(event is UpdateToDoList) {
      yield* _mapUpdateToDoItems(event);
    }
  }

  Stream<TodolistState> _mapGetToDoItems() async* {
    try {
      final items = await DatabaseConnection.db.getToDoItems();

      yield GetTodolistState(items);
      
    } catch (_) {
      yield ToDoNotLoaded();
    }
  }
  
  Stream<TodolistState> _mapDeleteToDoItems(DeleteToDoList event) async* {
    try {
      
      await DatabaseConnection.db.deleteToDOItem(event.id);
    } catch (_) {

      yield ToDoNotLoaded();
    }
  }

    Stream<TodolistState> _mapUpdateToDoItems(UpdateToDoList event) async* {
    try {
      
      await DatabaseConnection.db.upDateToDoItem(event.item);
    } catch (_) {

      yield ToDoNotLoaded();
    }
  }
}
