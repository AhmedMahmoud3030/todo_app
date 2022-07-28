import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:todo_app/models/task_model.dart';

class SQLHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE tasks(
        id TEXT ,
        title TEXT,
        date TEXT,
        starttime TEXT ,
        endtime TEXT ,
        remind TEXT ,
        repeat TEXT, 
        isFavorite TEXT,
        isCompleted TEXT
      )
      """);
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'tasks.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  // Create new task (journal)
  static Future<int> createTask(TaskModel model) async {
    final db = await SQLHelper.db();

    final data = {
      'id': model.id,
      'title': model.title,
      'date': model.date,
      'starttime': model.startTime,
      'endtime': model.endTime,
      'remind': model.remind,
      'repeat': model.repeat,
      'isFavorite': model.isFavorite.toString(),
      'isCompleted': model.isCompleted.toString(),
    };
    print('task in create');
    print(model.isCompleted.toString());
    print(model.isFavorite.toString());
    final id = await db.insert('tasks', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    print('task created');
    return id;
  }

  // Read all tasks (journals)
  static Future<List<Map<String, dynamic>>> getTasks() async {
    final db = await SQLHelper.db();
    return db.query('tasks');
  }

  // Read a single task by id
  // The app doesn't use this method but I put here in case you want to see it
  static Future<List<Map<String, dynamic>>> getTask(String id) async {
    final db = await SQLHelper.db();
    return db.query('tasks', where: "id = ?", whereArgs: [id], limit: 1);
  }

  // Update an task by id
  static Future<int> updateTask(TaskModel model) async {
    final db = await SQLHelper.db();

    final data = {
      'id': model.id,
      'title': model.title,
      'date': model.date,
      'starttime': model.startTime,
      'endtime': model.endTime,
      'remind': model.remind,
      'repeat': model.repeat,
      'isFavorite': model.isFavorite.toString(),
      'isCompleted': model.isCompleted.toString(),
    };

    final result =
        await db.update('tasks', data, where: "id = ?", whereArgs: [model.id]);
    return result;
  }

  // Delete
  static Future<void> deleteTask(String id) async {
    final db = await SQLHelper.db();
    try {
      await db.delete("tasks", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting a task: $err");
    }
  }
}
