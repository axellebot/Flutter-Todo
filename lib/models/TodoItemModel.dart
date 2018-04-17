import 'package:uuid/uuid.dart';

var uuid = new Uuid();

class TodoItemModel {
  String id;
  String name;
  String notes;
  bool done;

  TodoItemModel({this.id, this.name, this.notes, this.done = false}) {
    if (this.id == null) this.id = uuid.v4();
  }

  factory TodoItemModel.from(TodoItemModel todoItemModel) {
    return new TodoItemModel(
        id: todoItemModel.id,
        name: todoItemModel.name,
        notes: todoItemModel.notes,
        done: todoItemModel.done);
  }

  @override
  String toString() {
    return 'TodoItemModel{id: $id, name: $name, notes: $notes, done: $done}';
  }
}
