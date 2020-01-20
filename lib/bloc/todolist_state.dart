import 'package:equatable/equatable.dart';
import 'package:flutter_to_do/bloc/bloc.dart';
import 'package:flutter_to_do/db.dart';



abstract class TodolistState extends Equatable {
  const TodolistState();

  @override
  List<Object> get props => [];
}

class LoadingToDoListState extends TodolistState {}

class GetTodolistState extends TodolistState {
  final List<ToDoItem> items;

  const GetTodolistState([this.items = const []]);

  @override
  List<Object> get props => [items];

  @override
  String toString() => 'GetTodolistState { todos: $items }';
}

class DeleteToDoListState extends TodolistState {}

class UpdateToDoListState extends TodolistState {}

class ToDoNotLoaded extends TodolistState {}