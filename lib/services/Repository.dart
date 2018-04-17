import 'dart:async';

abstract class Repository<T> {
  Future<int> addItem(T item);
  Future<int> updateItem(T item) ;
  Future<int> deleteItem(T item);
  Future<T> getItem(String id);
  Future<List<T>> getItems();
}

class RespositoryException implements Exception {
  String _message;

  RespositoryException(this._message);

  String toString() {
    return "Exception: $_message";
  }
}