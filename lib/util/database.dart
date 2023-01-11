import 'package:hive_flutter/hive_flutter.dart';

class toDoDB {
  List todoList = [];
  final _data = Hive.box("myData");
//for first time opening of app
  void createInitialData() {
    todoList = ["Continue adding your task", false];
  }

  void loadData() {
    todoList = _data.get("TODOLIST");
  }

  void uploadData() {
    _data.put("TODOLIST", todoList);
  }
}
