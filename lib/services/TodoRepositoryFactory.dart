import 'package:todo/models/TodoItemModel.dart';
import 'package:todo/services/Repository.dart';
import 'package:todo/services/TodoLocalRepository.dart';
import 'package:todo/services/TodoMockRepository.dart';

class TodoRepositoryFactory {
  Repository<TodoItemModel> createRepository() {
    return createMockRepository();
  }

  Repository<TodoItemModel> createMockRepository() {
    return new TodoMockRepository();
  }

  Repository<TodoItemModel> createLocalRepository() {
    return new TodoLocalRepository();
  }
}
