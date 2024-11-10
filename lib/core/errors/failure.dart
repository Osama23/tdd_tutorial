
import 'package:equatable/equatable.dart';
import 'package:tdd_tutorial/core/errors/exceptions.dart';

abstract class Failure extends Equatable {

  const Failure({required this.message, required this.statusCode});

  final String message;
  final int statusCode;

  @override
  List<Object?> get props => [message, statusCode,];
}

class APIFailure extends Failure {
  const APIFailure({required super.message, required super.statusCode,});

  // *** this.will remove passing the values directly
  APIFailure.fromException(APIException exception) :
        this(message: exception.message, statusCode: exception.statusCode,);
}