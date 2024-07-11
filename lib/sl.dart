import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:reqres/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:reqres/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:reqres/features/auth/domain/repositories/auth_repository.dart';
import 'package:reqres/features/auth/domain/usecases/login.dart';
import 'package:reqres/features/auth/domain/usecases/register.dart';
import 'package:reqres/features/auth/presentation/cubit/login_cubit.dart';
import 'package:reqres/features/auth/presentation/cubit/register_cubit.dart';
import 'package:reqres/utils/report_service.dart';
import 'package:reqres/utils/shared_pref.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Shared Preference
  final sharedPreferences = await SharedPreferences.getInstance();

  //! Features
  // Bloc

  // Home
  sl.registerFactory(() => LoginCubit(login: sl(), sharedPref: sl()));
  sl.registerFactory(() => RegisterCubit(register: sl()));

  // Use cases
  sl.registerLazySingleton(() => Login(sl()));
  sl.registerLazySingleton(() => Register(sl()));

  // Repository
  sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(remoteDataSource: sl()));

  // Data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(client: sl()));

  //! External
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(
      () => SharedPref(sharedPreferences: sharedPreferences));
  sl.registerLazySingleton(() => ReportService(client: sl()));
}
