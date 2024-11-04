import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_tutorial/core/errors/exceptions.dart';
import 'package:tdd_tutorial/core/errors/failure.dart';
import 'package:tdd_tutorial/features/authentication/data/datasources/authentication_remote_data_source.dart';
// import 'package:tdd_tutorial/features/authentication/data/models/user_model.dart';
import 'package:tdd_tutorial/features/authentication/data/repositories/authentication_repository_impl.dart';
import 'package:tdd_tutorial/features/authentication/domain/entities/user.dart';

class MockAuthenticationRepositoryImpl extends Mock
    implements AuthenticationRemoteDataSource {}

void main() {
  late AuthenticationRemoteDataSource remoteDataSource;
  late AuthenticationRepositoryImpl repoImpl;

  setUp(() {
    remoteDataSource = MockAuthenticationRepositoryImpl();
    repoImpl = AuthenticationRepositoryImpl(remoteDataSource);
  });

  const tException = APIException(
    message: 'Unknown Error Occurred', // Unknown Error Occurred
    statusCode: 500,);

  group('createUser', () {
    const createdAt = 'whatever.createdAt';
    const name = 'whatever.name';
    const avatar = 'whatever.avatar';

    // 1- test call
    test('Should call the [RemoteDataSource.createUser] and complete successfully '
        'when the call to the remote source is successful', () async {
      // Arrange
      when(()=> remoteDataSource.createUser(
          createdAt: any(named: 'createdAt'),
          name: any(named: 'name'), 
          avatar: any(named: 'avatar'),)
      ).thenAnswer((_) async => Future.value(),); // whenever your return a void replace with Future.value
      // Act
      final result = await repoImpl.createUser(createdAt: createdAt, name: name, avatar: avatar);

      // Assert
      expect(result, equals(const Right(null))); // here also whenever your right is a void replace with null

      // Check if the remote data source is called with the right value
      verify(()=> remoteDataSource.createUser(createdAt: createdAt, name: name, avatar: avatar),).called(1);

      verifyNoMoreInteractions(remoteDataSource);
    });

    test(
      'should return a [APIFailure] when the call to the remote '
          'source is unsuccessful',
          () async {
        //  Arrange
        when(() =>
            remoteDataSource.createUser(
                createdAt: any(named: 'createdAt'),
                name: any(named: 'name'),
                avatar: any(
                  named: 'avatar',
                )),).thenThrow(const APIException(
          message: 'Unknown Error Occurred', statusCode: 500,));

        final result = await repoImpl.createUser(
          createdAt: createdAt,
          name: name,
          avatar: avatar,
        );

        expect(
          result,
          equals(
            Left(
              APIFailure(
                message: tException.message,
                statusCode: tException.statusCode,
              ),
            ),
          ),
        );
        verify(() =>
            remoteDataSource.createUser(
                createdAt: createdAt, name: name, avatar: avatar)).called(1);

        verifyNoMoreInteractions(remoteDataSource);
      },
    );
  });

  group('getUsers', () {

    // final tResponse = [const UserModel.empty(),];
    // 1- test call
    test('Should call the [RemoteDataSource.getUsers] and return [List<User>] '
        'when the call to the remote source is successful', () async {
      // Arrange
      // when(()=> remoteDataSource.getUsers()).thenAnswer((_) async => tResponse,);
      when(()=> remoteDataSource.getUsers()).thenAnswer((_) async => [],);
      // Act
      final result = await repoImpl.getUsers();

      // Assert
      // expect(result, equals(Right(tResponse))); // this works too

      expect(result, isA<Right<dynamic, List<User>>>());
      // Check if the remote data source is called with the right value
      verify(()=> remoteDataSource.getUsers(),).called(1);

      verifyNoMoreInteractions(remoteDataSource);
    });

    test(
      'should return a [APIFailure] when the call to the remote '
          'source is unsuccessful',
          () async {
        //  Arrange
        when(() =>
            remoteDataSource.getUsers(),).thenThrow(const APIException(
          message: 'Unknown Error Occurred', statusCode: 500,),);

        final result = await repoImpl.getUsers();

        // expect(
        //   result,
        //   equals(
        //     Left(
        //       APIFailure(
        //         message: tException.message,
        //         statusCode: tException.statusCode,
        //       ),
        //     ),
        //   ),
        // );

        expect(result, equals(Left(APIFailure.fromException(tException))));

        verify(() => remoteDataSource.getUsers(),).called(1);

        verifyNoMoreInteractions(remoteDataSource);
      },
    );
  });

}