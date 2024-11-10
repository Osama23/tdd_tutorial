import 'package:get_it/get_it.dart';
import 'package:tdd_tutorial/features/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:tdd_tutorial/features/authentication/data/repositories/authentication_repository_impl.dart';
import 'package:tdd_tutorial/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:tdd_tutorial/features/authentication/domain/usecases/create_user_use_case.dart';
import 'package:tdd_tutorial/features/authentication/domain/usecases/get_users_use_case.dart';
import 'package:tdd_tutorial/features/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:http/http.dart' as http;


final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(
      () => AuthenticationCubit(createUser: sl(), getUsers: sl())); // Presentation layer
  sl.registerLazySingleton(() => CreateUserUseCase(sl())); // Domain layer
  sl.registerLazySingleton(() => GetUsersUseCase(sl())); // Domain layer
  sl.registerLazySingleton<AuthenticationRepository>(
      () => AuthenticationRepositoryImpl(sl())); // Domain layer
  sl.registerLazySingleton<AuthenticationRemoteDataSource>(
      () => AuthenticationRemoteDataSourceImpl(sl())); // Data layer To External Storage
  sl.registerLazySingleton(() => http.Client());
}
