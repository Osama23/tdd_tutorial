import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_tutorial/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:tdd_tutorial/features/authentication/domain/usecases/create_user_use_case.dart';

import 'authentication_repository.mock.dart';


void main() {
  late CreateUserUseCase createUserUseCase;
  late AuthenticationRepository repository;

  setUp(() {
    repository = MockAuthenticationRepository();
    createUserUseCase = CreateUserUseCase(repository);
  });

  // final params = const CreateUserParams(
  //   name: "Name",
  //   createdAt: "CreatedAt",
  //   avatar: "Avatar",
  // );

  final params = CreateUserParams.empty();

  // setUpAll(() {
  //
  // });

  test('Should call the repository [MockAuthenticationRepository.createUser]',
      () async {
    // Arrange
    // when(() => repository.createUser(createdAt: createdAt, name: name, avatar: avatar));
    // any means find a generic value and use it
    when(() => repository.createUser(
          createdAt: any(named: 'createdAt'),
          name: any(named: 'name'),
          avatar: any(named: 'avatar'),
        )).thenAnswer((_) async => const Right(null));

    // Act
    final result = await createUserUseCase(params);

    // Assert
    expect(result, equals(const Right<dynamic, void>(null)));
    verify(() => repository.createUser(
        createdAt: params.createdAt, name: params.name, avatar: params.avatar)).called(1);

    verifyNoMoreInteractions(repository);

  });
}
