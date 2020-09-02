import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/managers/todo_manager.dart';
import 'package:todo_app/model/todo_item.dart';

class ToDoClosedScreen extends StatefulWidget {
  @override
  State<ToDoClosedScreen> createState() => ToDoClosedScreenState();

}

class ToDoClosedScreenState extends State<ToDoClosedScreen> {

  List<ToDoItem> _items = [];

  void updateClosed() {
    setState(() {
      _items = ToDoManager.getClosedTodDos();
    });
  }

  @override
  void initState() {
    super.initState();
    ToDoManager.setUpdateClosedFunction(updateClosed);
    this.updateClosed();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView.builder(
          addAutomaticKeepAlives: true,
          itemCount: _items.length,
          itemBuilder: (context, index) {
            final item = _items.elementAt(index);
            return item.toWidget(null, false);
          },
        ),
      ],
    );
  }

}