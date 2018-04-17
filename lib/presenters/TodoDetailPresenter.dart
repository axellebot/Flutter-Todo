import 'package:todo/models/TodoItemModel.dart';
import 'package:todo/services/Injector.dart';
import 'package:todo/services/IRepository.dart';
import 'package:todo/views/TodoDetailView.dart';

class TodoDetailPresenter {
  TodoDetailView _view;
  IRepository<TodoItemModel> _repository;

  TodoDetailPresenter(this._view) {
    _repository = Injector.todoRepository;
  }

  void saveTodoItem(TodoItemModel todoItem) {
    assert(_view != null);
    _repository.addItem(todoItem).then((int succeed) {
      _view.showSaveTaskComplete(succeed);
    }).catchError((onError) {
      _view.showSaveTaskError();
    });
  }

  void deleteTodoItem(TodoItemModel todoItem) {
    assert(_view != null);
    _repository.deleteItem(todoItem).then((int) {}).catchError((onError) {});
  }
}
