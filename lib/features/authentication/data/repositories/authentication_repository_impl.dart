
import 'package:dartz/dartz.dart';
import 'package:tdd_tutorial/core/errors/failure.dart';
import 'package:tdd_tutorial/core/utils/typedef.dart';
import 'package:tdd_tutorial/features/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:tdd_tutorial/features/authentication/domain/entities/user.dart';
import 'package:tdd_tutorial/features/authentication/domain/repositories/authentication_repository.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {

  final AuthenticationRemoteDataSource authenticationRemoteDataSource;

  AuthenticationRepositoryImpl(this.authenticationRemoteDataSource);

  @override
  ResultVoid createUser({
    required String createdAt, required String name,
    required String avatar}) async {

    final response = await authenticationRemoteDataSource.createUser(
        createdAt: createdAt, name: name, avatar: avatar,);
    // return response;
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<User>>> getUsers() async {
    final response = await authenticationRemoteDataSource.getUsers();

    // return response;
    throw UnimplementedError();
  }

}