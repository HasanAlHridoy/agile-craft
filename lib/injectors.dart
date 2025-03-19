import 'package:agile_crafts_task/src/core/database/hive_service.dart';
import 'package:agile_crafts_task/src/core/network/api_client.dart';
import 'package:agile_crafts_task/src/features/home/repository/home.dart';
import 'package:agile_crafts_task/src/features/sign_in/repository/signin.dart';
import 'package:get_it/get_it.dart';

final GetIt sl = GetIt.instance;

Future<void> initializeServiceLocator() async {

// Hive

  sl.registerSingleton<HiveService>(HiveService());

//Api Client
  sl.registerSingleton<ApiClient>(ApiClient(sl()));

// SignInRepository
  sl.registerSingleton<SignInRepository>(SignInRepository(sl(), sl()));
  sl.registerSingleton<HomeRepository>(HomeRepository(sl(), sl()));
}
