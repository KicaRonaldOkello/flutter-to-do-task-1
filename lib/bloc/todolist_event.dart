import 'package:equatable/equatable.dart';
import 'package:flutter_to_do/db.dart';



abstract class TodolistEvent extends Equatable {
  const TodolistEvent();

  @override
  List<Object> get props => [];
}

class GetToDoList extends TodolistEvent {

}

class DeleteToDoList extends TodolistEvent {
  final int id;

  const DeleteToDoList(this.id);
  
  @override
  List<Object> get props => [id];

  @override
  String toString() => 'DeleteToDoList { id: $id }';
}

class  UpdateToDoList  extends TodolistEvent {
  final ToDoItem item;


  const UpdateToDoList(this.item);

  @override
  List<ToDoItem> get props => [item];

  @override
  String toString() => 'UpdateToDoList $item';
}