import 'package:todo/models/TodoItemModel.dart';
import 'package:todo/services/IRepository.dart';
import 'package:todo/services/TodoRepositoryFactory.dart';

enum Flavor { MOCK, PROD }

/// Simple DI
class Injector {
  static final Injector _singleton = new Injector._internal();
  static Flavor _flavor;
  static IRepository<TodoItemModel> todoRepository;

  static void _initRepository() {
    TodoRepositoryFactory factory = new TodoRepositoryFactory();
    IRepository<TodoItemModel> repository;
    switch (_flavor) {
      case Flavor.MOCK:
        repository = factory.createMockRepository();
        break;
      default: // Flavor.PROD:
        repository = factory.createLocalRepository();
    }
    todoRepository = repository;
  }

  static void configure(Flavor flavor) {
    _flavor = flavor;
    _initRepository();
  }

  factory Injector() {
    return _singleton;
  }

  Injector._internal();
}
