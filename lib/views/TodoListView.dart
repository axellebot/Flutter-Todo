import 'package:todo/models/TodoItemModel.dart';

abstract class TodoListView {
  void showLoadingTasksComplete(List<TodoItemModel> items);
  void showLoadingTasksError();
}