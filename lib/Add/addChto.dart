import 'package:flutter_application_3/main.dart';
abstract class TaskDao {
  Future<void> insertTask(Task task);
}
class TaskRepository {
  final TaskDao taskDao;
  TaskRepository(this.taskDao);

  Future<void> addTask(String title) async {
    await taskDao.insertTask(Task(title: title,name: title,));
  }
}