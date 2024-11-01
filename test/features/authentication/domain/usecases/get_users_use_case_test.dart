// unit test question
// 1- what does the class depend on
// **** (what does this class takes in its constructor)
// 2 - How can we create a fake version of the dependency
// *** for example make a fake version of the http request
// 3- How do we control these dependencies (MockTail or Mockito)


// This class dependens on the AuthenticationRepository
// We control this using the Mocktail's Api

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_tutorial/features/authentication/domain/entities/user.dart';
import 'package:tdd_tutorial/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:tdd_tutorial/features/authentication/domain/usecases/get_users_use_case.dart';

import 'authentication_repository.mock.dart';

void main() {
  late GetUsersUseCase getUsersUseCase;
  late AuthenticationRepository repository;

  setUp(() {
    repository = MockAuthenticationRepository();
    getUsersUseCase = GetUsersUseCase(repository);
  });

  final tResponse = [const User.empty(),];

  test('Should call the repository [MockAuthenticationRepository.getUsers] and return List<User>', () async {

    when(() => repository.getUsers(),).thenAnswer((_) async => Right(tResponse),);

    // Act
    final result = await getUsersUseCase();

    // Assert
    expect(result, equals(Right<dynamic, List<User>> (tResponse),),);
    // This means that the repository get users has been called and it called only one time
    verify(() => repository.getUsers(),).called(1);

    verifyNoMoreInteractions(repository);
  });
}