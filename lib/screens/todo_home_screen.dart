import 'package:flutter/material.dart';
import 'package:todo_app/screens/todo_closed_screen.dart';
import 'package:todo_app/screens/todo_screen.dart';

class ToDoHomeScreen extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => ToDoHomeScreenState();

}

class ToDoHomeScreenState extends State<ToDoHomeScreen> {

 int _bottomNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Simple Todo App"),
        backgroundColor: Colors.black54,
      ),
      body: (this._bottomNavIndex == 0 ? ToDoScreen() : ToDoClosedScreen()),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: this._bottomNavIndex,
        backgroundColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.orangeAccent,
        onTap: (index) {
          setState(() {
            this._bottomNavIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle_outline),
            title: new Text("Todos"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle),
            title: new Text("Completed Todos"),
          ),
        ],
      ),
    );
  }
}