import 'package:mobx/mobx.dart';
part 'TasksController.g.dart';

class TasksController = _TasksControllerBase with _$TasksController;

abstract class _TasksControllerBase with Store {
  _TasksControllerBase({this.title});

  final String title;

  @observable
  bool done = false;

  @action
  void toggleDone() => done = !done;
}
