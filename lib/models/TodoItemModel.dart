import 'package:uuid/uuid.dart';
var uuid = new Uuid();

class TodoItemModel {
  String id;
  String name;
  String notes;
  bool done;

  TodoItemModel(this.name,this.notes){
    this.id = uuid.v4();
    this.done=false;
  }

  String get todo_item_id{
    return id;
  }

  void set todo_item_id(String id){
    this.id=id;
  }

  String get todo_item_name{
    return name;
  }

  void set todo_item_name(String name){
    this.name=name;
  }

  String get todo_item_notes{
    return notes;
  }

  void set todo_item_notes(String notes){
    this.notes=notes;
  }

  bool get todo_item_done{
    return done;
  }

  void set todo_item_done(bool done){
    this.done=done;
  }
}