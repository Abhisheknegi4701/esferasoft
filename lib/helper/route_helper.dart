
import 'package:esferasoft/view/screen/addtask.dart';
import 'package:esferasoft/view/screen/detail.dart';
import 'package:esferasoft/view/screen/edittask.dart';
import 'package:fluro/fluro.dart';

import '../view/screen/home.dart';
class RouteHelper {

  static final FluroRouter router = FluroRouter();

  static String home = '/home';
  static String detail = '/detail';
  static String addTask = '/addTask';
  static String editTask = '/editTask';

  static final Handler _homeHandler = Handler(handlerFunc: (context, Map<String, dynamic>? params) => const HomeScreen());
  static final Handler _detailHandler = Handler(handlerFunc: (context, Map<String, dynamic>? params) => const DetailScreen());
  static final Handler _addTaskHandler = Handler(handlerFunc: (context, Map<String, dynamic>? params) => const AddNewTask());
  static final Handler _editTaskHandler = Handler(handlerFunc: (context, Map<String, dynamic>? params) => const EditTask());

  static void setupRouter(){
    router.define(home, handler: _homeHandler, transitionType: TransitionType.fadeIn);
    router.define(detail, handler: _detailHandler, transitionType: TransitionType.fadeIn);
    router.define(addTask, handler: _addTaskHandler, transitionType: TransitionType.fadeIn);
    router.define(editTask, handler: _editTaskHandler, transitionType: TransitionType.fadeIn);
   }
}