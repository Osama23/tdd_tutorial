// unit test question
// 1- what does the class depend on
// **** (what does this class takes in its constructor)
// 2 - How can we create a fake version of the dependency
// *** for example make a fake version of the http request
// 3- How do we control these dependencies (MockTail or Mockito)

// *** Models doesn't depend on anything at all
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_tutorial/core/utils/typedef.dart';
import 'package:tdd_tutorial/features/authentication/data/models/user_model.dart';
import 'package:tdd_tutorial/features/authentication/domain/entities/user.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const tModel = UserModel.empty();

  // The first test is always to test if your class is a subclass of entity
  test('Should be a subclass of [user] entity', () {
    // Arrange
    const tModel = User.empty();
    // Act => We don't have to act as there is nothing to call
    
    // Assert
    expect(tModel, isA<User>());
  });

  final tJson = fixture('user.json');
  final tMap = jsonDecode(tJson) as DataMap;

  group('fromMap', () {
    test('Should return a [UserModel] with the right data', () {
      // Arrange
      // final tJson = File('test/fixtures/user.json').readAsStringSync();]

      // Act => We don't have to act as there is nothing to call
      final result = UserModel.fromMap(tMap);
      // Assert
      expect(result, equals(tModel));
    });
  });

  group('toMap', () {
    test('Should return a [Map] with the right data', () {
      // Arrange
      // final tJson = File('test/fixtures/user.json').readAsStringSync();]

      // Act => We don't have to act as there is nothing to call
      final result = tModel.toMap();
      // Assert
      expect(result, equals(tMap));
    });
  });

  group('toJson', () {
    test('Should return a [JSON] with the right data', () {
      // Arrange
      // final tJson = File('test/fixtures/user.json').readAsStringSync();]

      // Act => We don't have to act as there is nothing to call
      final result = tModel.toJson();
      final tJson = jsonEncode({
        "id": "1",
        "avatar": "_empty.avatar",
        "createdAt": "_empty.createdAt",
        "name": "_empty.name"
      });
      // Assert
      expect(result, equals(tJson));
    });
  });

  group('copyWith', () {
    test('Should return a [UserModel] with different data', () {
      // Arrange
      // final tJson = File('test/fixtures/user.json').readAsStringSync();]

      // Act => We don't have to act as there is nothing to call
      final result = tModel.copyWith(name: 'Paul');

      // Assert
      expect(result.name, equals('Paul'));
      // expect(result, NotEqula);
    });
  });
}