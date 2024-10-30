
import 'package:dartz/dartz.dart';
import 'package:tdd_tutorial/core/errors/failure.dart';

// typedef CreateUserFuture = Future<Either<Failure, void>>;

typedef ResultVoid = Future<Either<Failure, void>>;

typedef ResultFuture<T> = Future<Either<Failure, T>>;