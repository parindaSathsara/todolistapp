import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'task_model.dart';
import 'user_model.dart';
class DBHelper {

  int count=0;

  Future<Database> database() async {
    return openDatabase(
      join(await getDatabasesPath(), 'todolist.db'),
      onCreate: (db, version) async{
        await db.execute(
          'CREATE TABLE tasks(task_id INTEGER PRIMARY KEY AutoIncrement,task_name TEXT,task_date TEXT,task_description TEXT,task_status TEXT)',
        );
        await db.execute(
          'CREATE TABLE user(user_id INTEGER PRIMARY KEY AutoIncrement,user_name TEXT)',
        );

      },
      version: 1,
    );
  }

  Future<void> newTask(Tasks task) async {
    Database _database = await database();
    await _database.insert('tasks', task.toTaskMap(),conflictAlgorithm: ConflictAlgorithm.replace);
  }


  Future<void> newUser(Users user) async {
    Database _database = await database();
    await _database.insert('user', user.toUserMap(),conflictAlgorithm: ConflictAlgorithm.replace);
  }



  Future<int> getUserCount() async {
    Database _database = await database();
    var result = await _database.query('user');
    int count = result.length;
    return count;
  }


  Future<void> updateTask(int id,Tasks task) async {
    Database _database = await database();
    await _database.update('tasks', task.toTaskMap(),conflictAlgorithm: ConflictAlgorithm.replace,where:'task_id=?',whereArgs:[id]);
  }

  Future<void> updateTaskStatus(int id,String status) async {
    Database _database = await database();
    await _database.rawUpdate("UPDATE tasks SET task_status='$status' where task_id='$id'");
  }



  Future<void> deleteTask(int id) async {
    Database _database = await database();
    await _database.delete('tasks',where:'task_id=?', whereArgs: [id]);
  }

  Future<List<Tasks>> getTasks(String taskstatus,bool state,String date,String search) async {
    Database _database = await database();
    List<Map<String,dynamic>> taskMap;

    if(taskstatus=="Pending" || taskstatus=="Done"){
      taskMap=await _database.rawQuery("SELECT * FROM tasks WHERE task_status='$taskstatus' AND task_name LIKE '$search%'");
    }
    else {
      if (state == false) {
        taskMap = await _database.rawQuery(
            "SELECT * FROM tasks WHERE task_date='$date' AND task_name LIKE '$search%'");
      }
      else if (state == true) {
        taskMap = await _database.rawQuery(
            "SELECT * FROM tasks WHERE task_name LIKE '$search%'");
      }
      else {
        taskMap = await _database.rawQuery(
            "SELECT * FROM tasks WHERE task_date='$date' AND task_name LIKE '$search%'");
      }
    }

    return List.generate(taskMap.length, (index){
      return Tasks(task_id: taskMap[index]['task_id'],task_name: taskMap[index]['task_name'],task_date: taskMap[index]['task_date'],task_description: taskMap[index]['task_description'],task_status: taskMap[index]['task_status']);
    });
  }


  Future<List<Users>> getUser() async {
    Database _database = await database();
    List<Map<String,dynamic>> toUserMap=await _database.query("user",limit: 1);
    return List.generate(toUserMap.length, (index){
      return Users(user_name: toUserMap[index]['user_name']);
    });
  }
}
