import 'dart:async';

import 'package:todo/models/TodoItemModel.dart';
import 'package:todo/services/IRepository.dart';

class TodoMockRepository implements IRepository<TodoItemModel> {
  List<TodoItemModel> _list;

  TodoMockRepository() {
    _list = new List<TodoItemModel>.generate(16, (int index) {
      return new TodoItemModel(name: 'Name $index', notes: 'Notes $index');
    });
  }

  @override
  Future<int> addItem(TodoItemModel todoItem) {
    _list.add(todoItem);
    return Future.value(1);
  }

  @override
  Future<int> deleteItem(TodoItemModel todoItem) {
    int statement = (_list.remove(todoItem) == null) ? 0 : 1;
    return Future.value(statement);
  }

  @override
  Future<TodoItemModel> getItem(String id) {
    TodoItemModel _item = _list.where((e) => e.id == id).first;
    return Future.value(new TodoItemModel.from(_item));
  }

  @override
  Future<List<TodoItemModel>> getItems() {
    return Future.value(new List<TodoItemModel>.from(_list));
  }

  @override
  Future<int> updateItem(TodoItemModel todoItem) {
    TodoItemModel _item = _list.where((e) => e.id == todoItem.id).first;
    _list.remove(_item);
    _list.add(todoItem);
    return null;
  }
}
