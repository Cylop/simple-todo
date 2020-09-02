//Basic Model for one Todo_Item
import 'package:todo_app/model/todo_widget.dart';

class ToDoItem {
  int _id;

  String _name = "";
  String _description = "";
  List<String> _tags = new List(0);

  //metadata
  DateTime _creationDate = DateTime.now();
  DateTime _completedAt;
  bool _isDone = false;

  ToDoItem(this._name, this._description);

  int get getId => _id;
  String get getName => _name;
  String get getDescription => _description;
  List<String> get getTags => _tags;

  DateTime get getCreationDate => _creationDate;
  DateTime get getCompletionDate => _completedAt;
  bool get isDone => _isDone;

  void setId(int id) {
    this._id = id;
  }

  void complete() {
    this._isDone = true;
  }

  ToDoWidget toWidget(Function refresh, bool slidable) {
    return ToDoWidget(this, refresh, slidable);
  }

  ToDoItem.map(dynamic obj) {
    this._id = obj["id"];

    if(obj["name"] != null)
      this._name = obj["name"];

    if(obj["description"] != null)
      this._description = obj["description"];

    if(obj["creationDate"] != null)
      this._creationDate = DateTime.parse(obj["creationDate"]);

    if(obj["completionDate"] != null)
      this._completedAt = DateTime.parse(obj["completionDate"]);

    if(obj["tags"] != null)
      this._tags = obj["tags"];

    if(obj["isDone"] != null)
      this._isDone = obj["isDone"] == 1 ? true : false;
  }

  ToDoItem.fromMap(Map<String, dynamic> obj) {
    this._id = obj["id"];

    if(obj["name"] != null)
      this._name = obj["name"];

    if(obj["description"] != null)
      this._description = obj["description"];

    if(obj["creationDate"] != null)
      this._creationDate = DateTime.parse(obj["creationDate"]);

    if(obj["completionDate"] != null)
      this._completedAt = DateTime.parse(obj["completionDate"]);

    if(obj["tags"] != null)
      this._tags = obj["tags"];

    if(obj["isDone"] != null)
      this._isDone = obj["isDone"] == 1 ? true : false;
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (this._id != null)
      map["id"] = this._id;

    if(this._name != null)
      map["name"] = this._name;

    if(this._description != null)
      map["description"] = this._description;

    if(this._creationDate != null)
      map["creationDate"] = this._creationDate.toString();

    if(this._completedAt != null)
      map["completionDate"] = this._completedAt.toString();

    if(this._tags != null)
      map["tags"] = this._tags;

    if(this._isDone != null)
      map["isDone"] = this._isDone ? 1 : 0;

    return map;
  }
}