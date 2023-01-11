import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/util/database.dart';
import './util/todo_tile.dart';
import './util/alertbox.dart';
import 'package:intl/intl.dart';

void main() async {
  await Hive.initFlutter();
  var box = await Hive.openBox('myData');
  runApp(const ToDoApp());
}

class ToDoApp extends StatelessWidget {
  const ToDoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Home(),
      darkTheme: ThemeData(backgroundColor: Colors.black),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String fDate = DateFormat("dd-MM-yyyy").format(DateTime.now());

  final _box = Hive.box("myData");
  toDoDB db = toDoDB();

  @override
  void initState() {
    if (_box.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
    super.initState();
  }

  final _controller = TextEditingController();

  void checkChanged(bool? value, int index) {
    setState(() {
      db.todoList[index][1] = !db.todoList[index][1];
    });
    db.uploadData();
  }

  void savenewTask() {
    setState(() {
      if (_controller.text.length > 0) {
        db.todoList.insert(0, [_controller.text, false]);
        _controller.clear();
        Navigator.of(context).pop();
      }
    });
    db.uploadData();
  }

  void newTask() {
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
            controller: _controller,
            onSave: savenewTask,
            onCancel: () => Navigator.of(context).pop(),
          );
        });
    db.uploadData();
  }

  void deleteTask(int index) {
    setState(() {
      db.todoList.removeAt(index);
    });
    db.uploadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("ToDo App"),
        elevation: 0,
        backgroundColor: Colors.black,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey,
        onPressed: newTask,
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: db.todoList.length,
        itemBuilder: (context, index) {
          return ToDoTile(
              taskName: db.todoList[index][0],
              taskCompleted: db.todoList[index][1],
              onChanged: (value) => checkChanged(value, index),
              deleteFunction: (context) => deleteTask(index),
              date: fDate);
        },
      ),
    );
  }
}
