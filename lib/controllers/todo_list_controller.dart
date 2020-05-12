import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../models/todo_item_model.dart';

class TodoListController extends ChangeNotifier{
  final String _dbKey = 'todoList';
  Box<dynamic> _db;
  List<TodoItemModel> _todoList = [];


  // Constructor
  TodoListController(Box<dynamic> db) {
    _db=db;
    List<String> stringList = _db.containsKey(_dbKey)  ? _db.get(_dbKey) : [];
    makeTodoList(stringList);
  }

  // string to model translator
  void makeTodoList( List<String> stringList ){
    stringList.forEach((item) => _todoList.add(TodoItemModel(item))
    );
  }

  // model to string translator, to save to DB
  List<String> todoListToStringList(){
    List<String> stringList = [];
    _todoList.forEach((todoItem) => stringList.add(todoItem.toString()));
    return stringList;
  }

  // getters
  List<TodoItemModel> get todoList => _todoList;

  // create
  void add(String item){
    _todoList.add( TodoItemModel(item));
    _db.put(_dbKey, todoListToStringList());
    notifyListeners();
  }

  // delete
  void del(int index){
    _todoList.removeAt(index);
    _db.put(_dbKey, todoListToStringList());
    notifyListeners();
  }

}