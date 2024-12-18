import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:tdd_tutorial/core/errors/exceptions.dart';
import 'package:tdd_tutorial/core/utils/constants.dart';
import 'package:tdd_tutorial/features/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:tdd_tutorial/features/authentication/data/models/user_model.dart';
// import 'package:tdd_tutorial/features/authentication/data/datasources/authentication_remote_data_source_impl.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  late http.Client client;
  late AuthenticationRemoteDataSource remoteDataSource;

  setUp(() {
    client = MockClient();
    remoteDataSource = AuthenticationRemoteDataSourceImpl(client);
    registerFallbackValue(Uri());
  });

  group('createUser', () {
    test('should complete successfully when the status code is 200 or 201',
          () async {
        when(() => client.post(any(), body: any(named: 'body'))).thenAnswer(
              (_) async => http.Response('User created successfully', 201),
        );

        final methodCall = remoteDataSource.createUser;

        expect(
            methodCall(
              createdAt: 'createdAt',
              name: 'name',
              avatar: 'avatar',
            ),
            completes);

        verify(() =>
            client.post(Uri.parse('$kBaseUrl$kCreateUserEndpoint'),
              body: jsonEncode({
                'createdAt': 'createdAt',
                'name': 'name',
                'avatar': 'avatar',
              }),
            ),
        ).called(1);

        verifyNoMoreInteractions(client);
      },
    );

    test('should throw [APIException] when the status code is not 200 or '
        '201',
          () async {
        when(() => client.post(any(), body: any(named: 'body'))).thenAnswer(
              (_) async => http.Response('Invalid email address', 400,),
        );
        final methodCall = remoteDataSource.createUser;

        expect(
              () async =>
              methodCall(
                createdAt: 'createdAt',
                name: 'name',
                avatar: 'avatar',
              ),
          throwsA(
              const APIException(
                message: 'Invalid email address',
                statusCode: 400,)
          ),);

        verify(() =>
            client.post(Uri.parse('$kBaseUrl$kCreateUserEndpoint'),
              body: jsonEncode({
                'createdAt': 'createdAt',
                'name': 'name',
                'avatar': 'avatar',
              }),),
        ).called(1);

        verifyNoMoreInteractions(client);
      },
    );
  });

  group('getUser', () {
    const tUsers = [UserModel.empty()];
    test(
      'should return [List<User>] when the status code is 200',
          () async {
        when(() => client.get(Uri.https(kBaseUrl, kGetUsersEndpoint)))
            .thenAnswer(
              (_) async =>
              http.Response(jsonEncode([tUsers.first.toMap()]), 200),
        );

        final result = await remoteDataSource.getUsers();

        expect(result, equals(tUsers));

        verify(() => client.get(Uri.https(kBaseUrl, kGetUsersEndpoint,)))
            .called(1);
        verifyNoMoreInteractions(client);
      },
    );
  });

  test('should throw [APIException] when the status code is not 200', () async {
    const tMessage = 'Not found'; //  'Server down, Server down, I repeat Server down.';
    when(() => client.get(any(),)).thenAnswer(
          (_) async => http.Response(tMessage, 500),);
    final methodCall = remoteDataSource.getUsers;

    expect(
          () async =>
          methodCall(),
      throwsA(
          const APIException(
            message: 'Not found', // tMessage, // Not found
            statusCode: 500,),
      ),);

    // verify(() => client.get(Uri.https(kBaseUrl, kGetUsersEndpoint),),
    // ).called(1);

    // verifyNoMoreInteractions(client);
  });
}
