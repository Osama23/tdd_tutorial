// this will achieve the single responsibility principle
import 'package:equatable/equatable.dart';
import 'package:tdd_tutorial/core/usecase/usecase.dart';
import 'package:tdd_tutorial/core/utils/typedef.dart';
import 'package:tdd_tutorial/features/authentication/domain/repositories/authentication_repository.dart';

// class CreateUserUseCase {
//   const CreateUserUseCase(this._repository);
//
//   final AuthenticationRepository _repository;
//
//   ResultVoid createUser({
//     required String name,
//     required String createdAt,
//     required String avatar,
//   }) async =>
//     _repository.createUser(createdAt: createdAt, name: name, avatar: avatar);
//
// }

class CreateUserUseCase extends UseCaseWithParams<void, CreateUserParams> {
  const CreateUserUseCase(this._repository);

  final AuthenticationRepository _repository;

  ResultVoid createUser({
    required String name,
    required String createdAt,
    required String avatar,
  }) async =>
      _repository.createUser(createdAt: createdAt, name: name, avatar: avatar);

  @override
  ResultFuture call(CreateUserParams params) => _repository.createUser(
        createdAt: params.createdAt, // "something different",
        name: params.name,
        avatar: params.avatar,
      );
}

class CreateUserParams extends Equatable {
  const CreateUserParams({
    required this.name,
    required this.createdAt,
    required this.avatar,
  });

  const CreateUserParams.empty()
      : this(
            createdAt: '_empty.string',
            name: '_empty.string',
            avatar: '_empty.string',);

  final String name;
  final String createdAt;
  final String avatar;

  @override
  List<Object?> get props => [
        name,
        createdAt,
        avatar,
      ];
}
