
import 'package:esferasoft/data/model/response/task.dart';

import '../../services/api.dart';
import '../model/response/base/api_response.dart';

class HomeRepo {
  final MockApiService mockApiService;
  HomeRepo({required this.mockApiService});

  Future<ApiResponse> getTaskData(bool y) async {
    try{
      var response = await mockApiService.fetchTaskData(y);
      return ApiResponse.withSuccess(response);
    }catch(e){
      return ApiResponse.withError("Server Error");
    }
  }

  Future<ApiResponse> addTaskData(Task task) async {
    try{
      var response = await mockApiService.addTaskData(task);
      if(response){
        return ApiResponse.withSuccess(response);
      }else{
        return ApiResponse.withError(response);
      }
    }catch(e){
      return ApiResponse.withError("Server Error");
    }
  }

  Future<ApiResponse> editTaskData(Task task, int index) async {
    try{
      var response = await mockApiService.editTaskData(task, index);
      if(response){
        return ApiResponse.withSuccess(response);
      }else{
        return ApiResponse.withError(response);
      }
    }catch(e){
      return ApiResponse.withError("Server Error");
    }
  }

  Future<ApiResponse> updateStatus(int index) async {
    try{
      var response = await mockApiService.updateStatus(index);
      if(response){
        return ApiResponse.withSuccess(response);
      }else{
        return ApiResponse.withError(response);
      }
    }catch(e){
      return ApiResponse.withError("Server Error");
    }
  }

  Future<ApiResponse> deleteTaskData(int index) async {
    try{
      var response = await mockApiService.deleteTaskData(index);
      if(response){
        return ApiResponse.withSuccess(response);
      }else{
        return ApiResponse.withError(response);
      }
    }catch(e){
      return ApiResponse.withError("Server Error");
    }
  }


}