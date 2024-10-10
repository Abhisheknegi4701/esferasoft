
import 'package:esferasoft/provider/home_provider.dart';
import 'package:esferasoft/services/api.dart';
import 'package:get_it/get_it.dart';
import 'data/repository/home_repo.dart';

final sl = GetIt.instance;

Future<void> init() async {

  // Repository
  sl.registerLazySingleton(() => HomeRepo(mockApiService: sl()));

  sl.registerFactory(() => HomeProvider(homeRepo: sl()));

  // External
  final MockApiService mockApiService = MockApiService();
  sl.registerLazySingleton(() => mockApiService);
}