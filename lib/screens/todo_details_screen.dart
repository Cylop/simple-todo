import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sailor/sailor.dart';
import 'package:todo_app/managers/Routes.dart';
import 'package:todo_app/model/todo_item.dart';

class ToDoDetailsScreen extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => ToDoDetailsScreenState();

}

class ToDoPayload extends BaseArguments{
  final ToDoItem item;

  ToDoPayload(this.item);
}

class ToDoDetailsScreenState extends State<ToDoDetailsScreen> {

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final args = Sailor.args<ToDoPayload>(context);

    _nameController.text = args.item.getName;
    _descriptionController.text = args.item.getDescription;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: Text("Details of Todo #" + (args.item.getId+1).toString()),
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Form(
            key: _formKey,
            child: Column(
                children: <Widget>[
                  TextFormField(
                    enabled: false,
                    controller: _nameController,
                    maxLength: 150,
                    decoration: InputDecoration(
                      labelText: "Todo Name",
                      hoverColor: Colors.orangeAccent.withOpacity(0.3),
                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.orangeAccent)),
                      focusColor: Colors.orangeAccent,
                    ),
                  ),
                  TextFormField(
                    enabled: false,
                    controller: _descriptionController,
                    maxLength: 1000,
                    decoration: InputDecoration(
                      labelText: "Todo Description (optional)",
                      hoverColor: Colors.orangeAccent.withOpacity(0.3),
                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.orangeAccent)),
                      focusColor: Colors.orangeAccent,
                    ),
                  ),
                  RaisedButton(
                    child: Text("Back"),
                    color: Colors.orangeAccent,
                    splashColor: Colors.greenAccent,
                    onPressed: () {
                      Routes.sailor.pop();
                    },
                  ),
                ]
            )
        ),
      ),
    );
  }
}