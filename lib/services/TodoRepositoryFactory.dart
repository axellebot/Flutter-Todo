import 'package:todo/models/TodoItemModel.dart';
import 'package:todo/services/IRepository.dart';
import 'package:todo/services/TodoLocalRepository.dart';
import 'package:todo/services/TodoMockRepository.dart';

class TodoRepositoryFactory {
  IRepository<TodoItemModel> createRepository() {
    return createMockRepository();
  }

  IRepository<TodoItemModel> createMockRepository() {
    return new TodoMockRepository();
  }

  IRepository<TodoItemModel> createLocalRepository() {
    return new TodoLocalRepository();
  }
}
