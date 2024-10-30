
import 'package:dartz/dartz.dart';
import 'package:tdd_tutorial/core/utils/typedef.dart';
import 'package:tdd_tutorial/features/authentication/domain/entities/user.dart';
import 'package:tdd_tutorial/core/errors/failure.dart';

abstract class AuthenticationRepository {

  const AuthenticationRepository();

  // Future<void> createUser({required String createdAt, required String name, required String avatar,});
  // Future<(Exception, void)> createUser({required String createdAt, required String name, required String avatar,});

  // When using dartz we will keep the failure in the data layer,
  // but we will handle the failure in the domain layer which contains the message or the reason of the failure
  // Future<Either<Failure, void>> createUser({required String createdAt, required String name, required String avatar,});
  ResultVoid createUser({required String createdAt, required String name, required String avatar,});

  // Future<List<User>> getUsers();
  Future<Either<Failure, List<User>>> getUsers();

}