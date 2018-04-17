import 'package:todo/models/TodoItemModel.dart';
import 'package:todo/services/Repository.dart';
import 'package:todo/services/TodoRepositoryFactory.dart';
import 'package:todo/views/TodoListView.dart';

class TodoListPresenter {
  TodoListView _view;
  Repository<TodoItemModel> _repository;

  TodoListPresenter(this._view) {
    _repository = new TodoRepositoryFactory().createRepository();
  }

  void loadTodoList() {
    assert(_view != null);

    _repository.getItems().then((tasks) {
      _view.showLoadingTasksComplete(tasks);
    }).catchError((onError) {
      print(onError);
      _view.showLoadingTasksError();
    });
  }

  void saveTodoItem(TodoItemModel todoItem) {
    assert(_view != null);

    _repository.addItem(todoItem).then((int) {}).catchError((onError) {});
  }

  void deleteTodoItem(TodoItemModel todoItem) {
    assert(_view != null);

    _repository.deleteItem(todoItem).then((int) {}).catchError((onError) {});
  }
}
