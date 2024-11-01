import 'dart:convert';

import 'package:tdd_tutorial/core/utils/typedef.dart';
import 'package:tdd_tutorial/features/authentication/domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.name,
    required super.createdAt,
    required super.avatar,
  });

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(jsonDecode(source) as DataMap);

  UserModel.fromMap(DataMap map) : this(
    avatar: map['avatar'] as String,
    id: map['id'] as String,
    createdAt: map['createdAt'] as String,
    name: map['name'] as String,
  );

  UserModel copyWith({
    String? avatar,
    String? name,
    String? id,
    String? createdAt,
  }) {
    return UserModel(
        id: id ?? this.id,
        name: name ?? this.name,
        createdAt: createdAt ?? this.createdAt,
        avatar: avatar ?? this.avatar,
    );
  }

  DataMap toMap() => {
    'id': id,
    'avatar': avatar,
    'name': name,
    'createdAt': createdAt,
  };

  String toJson() => jsonEncode(toMap());

}