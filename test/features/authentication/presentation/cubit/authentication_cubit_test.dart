import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_tutorial/core/errors/failure.dart';
import 'package:tdd_tutorial/features/authentication/domain/usecases/create_user_use_case.dart';
import 'package:tdd_tutorial/features/authentication/domain/usecases/get_users_use_case.dart';
import 'package:tdd_tutorial/features/authentication/presentation/cubit/authentication_state.dart';
import 'package:tdd_tutorial/features/authentication/presentation/cubit/authentication_cubit.dart';

class MockGetUsers extends Mock implements GetUsersUseCase {}

class MockCreateUser extends Mock implements CreateUserUseCase {}

void main() {
  late GetUsersUseCase getUsers;
  late CreateUserUseCase createUser;
  late AuthenticationCubit cubit;

  const tCreateUserParams = CreateUserParams.empty();
  const tAPIFailure = APIFailure(
    message: 'message',
    statusCode: 400,
  );

  setUp(() {
    getUsers = MockGetUsers();
    createUser = MockCreateUser();
    cubit = AuthenticationCubit(
      createUser: createUser,
      getUsers: getUsers,
    );
    registerFallbackValue(tCreateUserParams);
  });

  // This will remove all the created instances
  tearDown(() => cubit.close());

  test('Test Initial State', () async {
    expect(cubit.state, const AuthenticationInitial());
  });

  group('Create User', () {
    blocTest<AuthenticationCubit, AuthenticationState>(
      'Should emit [CreatingUser, UserCreated] when successful',
      build: () {
        when(() => createUser(any())).thenAnswer(
          (_) async => const Right(null),
        );
        return cubit;
      },
      // act: (bloc) => bloc.add(CreateUserParams(createdAt: 'createdAt', name: 'name', avatar: 'avatar')),
      act: (cubit) => cubit.createUser(
        createdAt: tCreateUserParams.createdAt, // 'createdAt',
        name: tCreateUserParams.name, // 'name',
        avatar: tCreateUserParams.avatar, // 'avatar',
      ),
      expect: () => const [CreatingUser(), UserCreated()],
      verify: (_) {
        createUser(tCreateUserParams);
      },
    );

    blocTest<AuthenticationCubit, AuthenticationState>(
      'Should emit [CreatingUser, AuthenticationError] when unsuccessful',
      build: () {
        when(() => createUser(any())).thenAnswer(
          (_) async => const Left(tAPIFailure),
        );
        return cubit;
      },
      act: (cubit) => cubit.createUser(
        createdAt: tCreateUserParams.createdAt, // 'createdAt',
        name: tCreateUserParams.name, // 'name',
        avatar: tCreateUserParams.avatar, // 'avatar',
      ),
      expect: () =>
          [const CreatingUser(), AuthenticationError(tAPIFailure.message)],
      verify: (_) {
        createUser(tCreateUserParams);
      },
    );
  });

  group('Getting Users', () {
    blocTest<AuthenticationCubit, AuthenticationState>(
      'Should emit [GettingUsers, UsersLoaded] when successful',
      build: () {
        when(() => getUsers()).thenAnswer(
          (_) async => const Right([]),
        );
        return cubit;
      },
      // act: (bloc) => bloc.add(CreateUserParams(createdAt: 'createdAt', name: 'name', avatar: 'avatar')),
      act: (cubit) => cubit.getUsers(),
      expect: () => const [GettingUsers(), UsersLoaded([])],
      verify: (_) {
        verify(() => getUsers()).called(1);
        verifyNoMoreInteractions(getUsers);
      },
    );

    blocTest<AuthenticationCubit, AuthenticationState>(
      'Should emit [GettingUsers, AuthenticationError] when unsuccessful',
      build: () {
        when(() => getUsers()).thenAnswer(
          (_) async => const Left(tAPIFailure),
        );
        return cubit;
      },
      act: (cubit) => cubit.getUsers(),
      expect: () =>
          [const GettingUsers(), AuthenticationError(tAPIFailure.message)],
      verify: (_) {
        verify(() => getUsers()).called(1);
        verifyNoMoreInteractions(getUsers);
      },
    );
  });
}
