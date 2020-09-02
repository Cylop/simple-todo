import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sailor/sailor.dart';
import 'package:todo_app/managers/Routes.dart';
import 'package:todo_app/managers/todo_manager.dart';
import 'package:todo_app/model/todo_item.dart';

class ToDoScreen extends StatefulWidget {
  State<StatefulWidget> createState() => ToDoScreenState();
}

class ToDoScreenState extends State<ToDoScreen> {
  
  List<ToDoItem> _items = [];
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();

  void addItem(ToDoItem item) {
    setState(() {
      _items.insert(0, item);
      _listKey.currentState.insertItem(0);
    });
  }

  void removeItem(int id) {
    int index = _items.indexWhere((element) => element.getId == id);
    ToDoItem item = _items.elementAt(index);
    _listKey.currentState.removeItem(index, (context, animation) => _buildItem(context, item, animation, null, false));
    _items.removeAt(index);
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _items = ToDoManager.getOpenToDos();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedList(
          key: _listKey,
          initialItemCount: _items.length,
          itemBuilder: (context, index, animation) {
            final item = _items.elementAt(index);
            return _buildItem(context, item, animation, removeItem, true);
          },

        ),
        Padding(
          padding: EdgeInsets.all(13),
          child: Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton(
              backgroundColor: Colors.orangeAccent,
                heroTag: null,
                child: Icon(Icons.note_add),
                onPressed: () {
                  Routes.sailor.navigate(Routes.ROUTE_CREATE_TODO, args: ToDoArgs(this.addItem));
                },
            ),
          ),
        ),
      ],
    );
  }
}

Widget _buildItem(BuildContext context, ToDoItem item, Animation<double> animation, Function remove, bool slidable) {
  return SlideTransition(
    position: Tween<Offset>(
      begin: const Offset(-1, 0),
      end: Offset.zero,
    ).animate(animation),
    child: item.toWidget(remove, slidable),
  );
}

class ToDoArgs extends BaseArguments{
  
  Function refresh;
  
  ToDoArgs(this.refresh);
  
}