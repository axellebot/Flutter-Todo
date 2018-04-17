import 'dart:async';

import 'package:todo/models/TodoItemModel.dart';
import 'package:todo/services/Repository.dart';

class TodoLocalRepository  implements Repository<TodoItemModel>{
  @override
  Future<int> addItem(TodoItemModel item) async{
    // TODO: implement addItem
    return null;
  }

  @override
  Future<int> deleteItem(TodoItemModel item) async{
    // TODO: implement deleteItem
    return null;
  }

  @override
  Future<TodoItemModel> getItem(String id) async{
    // TODO: implement getItem
    return null;
  }

  @override
  Future<List<TodoItemModel>> getItems() async{
    // TODO: implement getItems
    return null;
  }

  @override
  Future<int> updateItem(TodoItemModel item) async{
    // TODO: implement updateItem
    return null;
  }

}