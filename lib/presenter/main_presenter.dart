import 'package:todolistapp/models/dbhelper.dart';
import 'package:todolistapp/models/task_model.dart';
import 'package:todolistapp/models/user_model.dart';

class Presenter{
  DBHelper _dbhelper = DBHelper();

  Future<void> insertTask(String task_name,String task_date,String task_description,String task_status)async {

    Tasks _newTask = Tasks(
      task_name: task_name,
      task_date: task_date,
      task_description: task_description,
      task_status: task_status,
    );
    await _dbhelper.newTask(_newTask);
  }

  Future<void> updateTask(int task_id,String task_name,String task_date,String task_description,String task_status)async {

    Tasks _updateTask = Tasks(
      task_id: task_id,
      task_name: task_name,
      task_date: task_date,
      task_description: task_description,
      task_status: task_status,
    );
    await _dbhelper.updateTask(task_id, _updateTask);
  }


  Future<void> deleteTask(int task_id)async {
    await _dbhelper.deleteTask(task_id);
  }

  Future<void> updateStatus(int task_id,String task_status)async {
    await _dbhelper.updateTaskStatus(task_id, task_status);
  }
}



