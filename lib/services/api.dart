
import 'package:esferasoft/data/model/response/task.dart';

class MockApiService {

  Tasks taskList = Tasks(task: [
    Task.fromJson({
      "name": "Interview",
      "description":"Interview At Esferasoft",
      "deadline": 1728581400000,
      "priority": 2,
      "status": 0,
      "created": 1728476637000,
      "updated": 0,
      "deleted": false
    }),
    Task.fromJson({
      "name": "Project",
      "description":"Project New Updates",
      "deadline": 1729445400000,
      "priority": 0,
      "status": 1,
      "created": 1728476637000,
      "updated": 0,
      "deleted": false
    }),
    Task.fromJson({
      "name": "Project 2",
      "description":"Project Stuck at errors",
      "deadline": 1729013400000,
      "priority": 1,
      "status": 0,
      "created": 1728476637000,
      "updated": 0,
      "deleted": false
    })
  ]);

  Future<Tasks> fetchTaskData(bool y) async {
    if(y){
      await Future.delayed(Duration(seconds: 2));
    }
    return taskList; // Returning the mock data
  }

  Future<bool> addTaskData(Task task) async {
    try{
      await Future.delayed(Duration(seconds: 2));
      (taskList.task ?? []).add(task);
      return true;
    }catch(e){
      return false;
    }
  }

  Future<bool> editTaskData(Task task, int index) async {
    try{
      await Future.delayed(Duration(seconds: 2));
      (taskList.task ?? [])[index] = task;
      return true;
    }catch(e){
      return false;
    }
  }

  Future<bool> updateStatus(int index) async {
    try{
      await Future.delayed(Duration(seconds: 2));
      (taskList.task ?? [])[index].status = 1;
      return true;
    }catch(e){
      return false;
    }
  }

  Future<bool> deleteTaskData(int index) async {
    try{
      await Future.delayed(Duration(seconds: 2));
      (taskList.task ?? []).removeAt(index);
      return true;
    }catch(e){
      return false;
    }
  }

}