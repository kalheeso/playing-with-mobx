import 'package:mobx/mobx.dart';
import 'package:todomobx/controllers/TasksController.dart';
part 'ListController.g.dart';

class ListController = _ListControllerBase with _$ListController;

abstract class _ListControllerBase with Store {
  @observable
  String newTask = '';

  @action
  void setTaskTitle(String value) => newTask = value;

  @computed
  bool get isFormValid => newTask.isNotEmpty;

  ObservableList<TasksController> tasksList =
      new ObservableList<TasksController>();

  @action
  void addTask() {
    tasksList.insert(0, TasksController(title: newTask));
    newTask = "";
  }
}
