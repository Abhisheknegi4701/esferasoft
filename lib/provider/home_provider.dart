
import 'package:esferasoft/data/model/response/task.dart';
import 'package:flutter/material.dart';

import '../data/repository/home_repo.dart';

class HomeProvider extends ChangeNotifier {
  final HomeRepo homeRepo;
  HomeProvider({required this.homeRepo});

  String _getTaskListErrorMessage = '';
  String get getTaskListErrorMessage => _getTaskListErrorMessage;
  bool _getTaskDataLoading = false;
  bool get getTaskDataLoading => _getTaskDataLoading;
  String _editTaskListErrorMessage = '';
  String get editTaskListErrorMessage => _editTaskListErrorMessage;
  bool _editTaskDataLoading = false;
  bool get editTaskDataLoading => _editTaskDataLoading;
  String _addTaskListErrorMessage = '';
  String get addTaskListErrorMessage => _addTaskListErrorMessage;
  bool _addTaskDataLoading = false;
  bool get addTaskDataLoading => _addTaskDataLoading;
  String _deleteTaskListErrorMessage = '';
  String get deleteTaskListErrorMessage => _deleteTaskListErrorMessage;
  bool _deleteTaskDataLoading = false;
  bool get deleteTaskDataLoading => _deleteTaskDataLoading;
  String _updateStatusTaskListErrorMessage = '';
  String get updateStatusTaskListErrorMessage => _updateStatusTaskListErrorMessage;
  bool _updateStatusTaskDataLoading = false;
  bool get updateStatusTaskDataLoading => _updateStatusTaskDataLoading;
  Tasks allTaskList = Tasks();
  Tasks filteredList = Tasks();
  int selectedIndex = -1;
  int selectedFiltered = -1;

  updateSelectedIndex(int index){
    selectedIndex = index;
    notifyListeners();
  }

  Future<void> getTaskData(bool y) async {
    _getTaskListErrorMessage = '';
    _getTaskDataLoading = true;
    await homeRepo.getTaskData(y).then((apiResponse) {
      if (apiResponse.response != null) {
        allTaskList = apiResponse.response;
        _getTaskDataLoading = false;
        notifyListeners();
      } else {
        _getTaskDataLoading = false;
        _getTaskListErrorMessage = apiResponse.error.toString();
        notifyListeners();
      }
    });
  }

  Future<void> filterList(int index) async {
    selectedFiltered = index;
    notifyListeners();
  }

  Future<bool> addTask(Task task) async {
    _addTaskListErrorMessage = '';
    _addTaskDataLoading = true;
    notifyListeners();
    return await homeRepo.addTaskData(task).then((apiResponse) {
      if (apiResponse.response != null) {
        _addTaskDataLoading = false;
        getTaskData(false);
        notifyListeners();
        return true;
      } else {
        _addTaskListErrorMessage = 'Task Not Added. Try Again Later';
        _addTaskDataLoading = false;
        notifyListeners();
        return false;
      }
    });
  }

  Future<bool> updateStatus() async {
    _updateStatusTaskListErrorMessage = '';
    _updateStatusTaskDataLoading = true;
    notifyListeners();
    return await homeRepo.updateStatus(selectedIndex).then((apiResponse) {
      if (apiResponse.response != null) {
        _updateStatusTaskDataLoading = false;
        getTaskData(false);
        notifyListeners();
        return true;
      } else {
        _updateStatusTaskListErrorMessage = 'Task Not Added. Try Again Later';
        _updateStatusTaskDataLoading = false;
        notifyListeners();
        return false;
      }
    });
  }

  Future<bool> editTask(Task task) async {
    _editTaskListErrorMessage = '';
    _editTaskDataLoading = true;
    notifyListeners();
    return await homeRepo.editTaskData(task, selectedIndex).then((apiResponse) {
      if (apiResponse.response != null) {
        _editTaskDataLoading = false;
        getTaskData(false);
        notifyListeners();
        return true;
      } else {
        _editTaskListErrorMessage = 'Task Not Updated. Try Again Later';
        _editTaskDataLoading = false;
        notifyListeners();
        return false;
      }
    });
  }

  Future<bool> deleteTask() async {
    _deleteTaskListErrorMessage = '';
    _deleteTaskDataLoading = true;
    notifyListeners();
    return await homeRepo.deleteTaskData(selectedIndex).then((apiResponse) {
      if (apiResponse.response != null) {
        getTaskData(false);
        _deleteTaskDataLoading = false;
        notifyListeners();
        return true;
      } else {
        _deleteTaskListErrorMessage = 'Task Not Deleted. Try Again Later';
        _deleteTaskDataLoading = false;
        notifyListeners();
        return false;
      }
    });
  }


}