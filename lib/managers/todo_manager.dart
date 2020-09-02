import 'dart:collection';

import 'package:todo_app/database/database_client.dart';
import 'package:todo_app/model/todo_item.dart';

class ToDoManager {

  static final Map<int, ToDoItem> _todo_items = new HashMap();
  static final DatabaseHelper _databaseHelper = DatabaseHelper();

  static Function updateClosedFuntion;

  static void setUpdateClosedFunction(Function fun) {
    updateClosedFuntion = fun;
  }

  static Future<List> readToDoItems() async {
    List items = await _databaseHelper.getItems();
    items.forEach((item) {
      ToDoItem todo = ToDoItem.map(item);
      _todo_items[todo.getId] = todo;
    });
    return _todo_items.values.toList();
  }

  static Future<ToDoItem> saveTodo(ToDoItem item) async {
    int id = await _databaseHelper.saveItem(item);
    ToDoItem fetched = await _databaseHelper.getItem(id);
    _todo_items[fetched.getId] = fetched;
    return fetched;
  }

  static Future<int> deleteTodo(int id) async {
    int count = await _databaseHelper.deleteItem(id);
    _todo_items.removeWhere((key, value) => key == id);
    return id;
  }

  static Map<int, ToDoItem> get getToDoItems => _todo_items;

  static List<ToDoItem> getOpenToDos() {
    List<ToDoItem> items = [];
    getToDoItems.forEach((key, value) {
      if(!value.isDone)
        items.add(value);
    });
    return items;
  }

  static List<ToDoItem> getClosedTodDos() {
    List<ToDoItem> items = [];
    getToDoItems.forEach((key, value) {
      if(value.isDone)
        items.add(value);
    });
    return items;
  }

  static Future<bool> markAsComplete(ToDoItem item) async {
    item.complete();
    int id = await _databaseHelper.updateItem(item);
    return id != null;
  }

}