import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/managers/Routes.dart';
import 'package:todo_app/managers/todo_manager.dart';
import 'package:todo_app/model/todo_item.dart';
import 'package:todo_app/screens/todo_details_screen.dart';

class ToDoWidget extends StatefulWidget {

  final ToDoItem _item;
  final Function refresh;
  final bool slidable;

  ToDoWidget(this._item, this.refresh, this.slidable);

  @override
  State<StatefulWidget> createState()  => ToDoWidgetState();

}

class ToDoWidgetState extends State<ToDoWidget> with SingleTickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 8.0,
        top: 8.0,
        right: 8.0,
      ),
      child: InkWell(
        onTap: () {
          Routes.sailor.navigate(Routes.ROUTE_DETAILS_TODO, args: ToDoPayload(widget._item));
        },
        child: Card(
          child: Slidable(
            closeOnScroll: true,
            actionPane: SlidableBehindActionPane(),
            enabled: widget.slidable,
            actions: [
              IconSlideAction(
                color: Colors.redAccent,
                icon: Icons.delete,
                caption: "Delete",
                onTap: () {
                  ToDoManager.deleteTodo(widget._item.getId).whenComplete(() {
                    if(widget.refresh != null) {
                      widget.refresh(widget._item.getId);
                    }
                    Fluttertoast.showToast(msg: "Task has been deleted!", backgroundColor: Colors.redAccent);
                  });
                },
              ),
            ],
            secondaryActions: [
              IconSlideAction(
                color: Colors.greenAccent,
                icon: Icons.check,
                caption: "Complete",
                onTap: () {
                  ToDoManager.markAsComplete(widget._item).then((value) {
                    if(widget.refresh != null) {
                      widget.refresh(widget._item.getId);
                    }
                    Fluttertoast.showToast(msg: "Task has been marked as complete!", backgroundColor: Colors.greenAccent);
                  });
                },
              ),
            ],
            child: Container(
              color: Colors.white,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: Chip(
                      label: Text("#" + (widget._item.getId+1).toString())
                    ),
                    title: Column(
                        children:[
                          Align(
                            alignment: Alignment.topRight,
                            child: Text(
                                "Created @ " + DateFormat('yyyy/MM/dd HH:mm').format(widget._item.getCreationDate),
                                style: TextStyle(
                                  fontSize: 9,
                                ),
                              ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(widget._item.getName),
                          ),
                        ],
                    ),
                    subtitle: Text(
                      widget._item.getDescription,
                      overflow: TextOverflow.clip,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
