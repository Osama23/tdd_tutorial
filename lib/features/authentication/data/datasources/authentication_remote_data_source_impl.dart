//
// import 'dart:convert';
//
// import 'package:http/http.dart' as http;
// import 'package:tdd_tutorial/core/utils/constants.dart';
// import 'package:tdd_tutorial/features/authentication/data/datasources/authentication_remote_data_source.dart';
// import 'package:tdd_tutorial/features/authentication/data/models/user_model.dart';
//
// class AuthenticationRemoteDataSourceImpl implements AuthenticationRemoteDataSource {
//   const AuthenticationRemoteDataSourceImpl(this._client);
//
//   final http.Client _client;
//
//   @override
//   Future<void> createUser({required String createdAt,
//     required String name, required String avatar,}) async{
//     //  1. check to make sure that it returns the right data when the status
//     //  code is 200 or the proper response code
//     //  2. check to make sure that it "THROWS A CUSTOM EXCEPTION" with the
//     //  right message when status code is the bad one
//     final response = await _client.post(
//       Uri.parse('$kBaseUrl$kCreateUserEndPoint'),
//       body: jsonEncode({
//         'createdAt': createdAt,
//         'name': name,
//         'avatar': avatar,
//       }),
//     );
//
//     // return response;
//   }
//
//   @override
//   Future<List<UserModel>> getUsers() {
//     // TODO: implement getUsers
//     throw UnimplementedError();
//   }
//
//   // @override
//   // Future<List<UserModel>> getUsers() async {
//   //
//   // }
//
// }