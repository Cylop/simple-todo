import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sailor/sailor.dart';
import 'package:todo_app/managers/Routes.dart';
import 'package:todo_app/managers/todo_manager.dart';
import 'package:todo_app/model/todo_item.dart';
import 'package:todo_app/screens/todo_screen.dart';

class ToDoCreateScreen extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => ToDoCreateScreenState();

}

class ToDoCreateScreenState extends State<ToDoCreateScreen> {

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final args = Sailor.args<ToDoArgs>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: Text("Create new Todo"),
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Form(
            key: _formKey,
            child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: _nameController,
                    maxLength: 150,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter a todo';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "Buy some Milk",
                      labelText: "Todo Name",
                      hoverColor: Colors.orangeAccent.withOpacity(0.3),
                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.orangeAccent)),
                      focusColor: Colors.orangeAccent,
                    ),
                  ),
                  TextFormField(
                    controller: _descriptionController,
                    maxLength: 1000,
                    decoration: InputDecoration(
                      hintText: "2 liters of milk from my favorite market",
                      labelText: "Todo Description (optional)",
                      hoverColor: Colors.orangeAccent.withOpacity(0.3),
                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.orangeAccent)),
                      focusColor: Colors.orangeAccent,
                    ),
                  ),
                  RaisedButton(
                    child: Text("Create"),
                    color: Colors.orangeAccent,
                    hoverColor: Colors.greenAccent,
                    splashColor: Colors.greenAccent,
                    autofocus: true,
                    clipBehavior: Clip.antiAlias,
                    onPressed: () {
                      if(_formKey.currentState.validate()) {
                        ToDoManager.saveTodo(ToDoItem(this._nameController.value.text, this._descriptionController.value.text)).then((value) {
                          Fluttertoast.showToast(msg: "Todo was saved", backgroundColor: Colors.greenAccent);
                          args.refresh(value);
                          Routes.sailor.pop();
                        });
                      }else{
                        Fluttertoast.showToast(
                          msg: "Todo is not valid",
                          backgroundColor: Colors.redAccent,
                          toastLength: Toast.LENGTH_LONG
                        );
                      }
                    },
                  ),
                ]
            )
        ),
      ),
    );
  }

}