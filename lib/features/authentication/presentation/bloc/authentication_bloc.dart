import 'package:bloc/bloc.dart';
import 'package:tdd_tutorial/features/authentication/domain/entities/user.dart';
import 'package:tdd_tutorial/features/authentication/domain/usecases/create_user_use_case.dart';
import 'package:tdd_tutorial/features/authentication/domain/usecases/get_users_use_case.dart';
import 'package:tdd_tutorial/features/authentication/presentation/bloc/authentication_state.dart';

import 'authentication_event.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    required CreateUserUseCase createUser,
    required GetUsersUseCase getUsers,
  })  : _createUser = createUser,
        _getUsers = getUsers,
        super(const AuthenticationInitial()) {
    on<CreateUserEvent>(_createUserHandler);
    on<GetUsersEvent>(_getUsersHandler);
  }

  final CreateUserUseCase _createUser;
  final GetUsersUseCase _getUsers;

  Future<void> _createUserHandler(
    CreateUserEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(const CreatingUser());

    final result = await _createUser(
      CreateUserParams(
        createdAt: event.createdAt,
        name: event.name,
        avatar: event.avatar,
      ),
    );

    result.fold(
      (failure) => emit(AuthenticationError('${failure.statusCode} Error: ${failure.message}'),),
      (_) => emit(const UserCreated(),),
    );
  }

  Future<void> _getUsersHandler(
    GetUsersEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(const GettingUsers());

    final result = await _getUsers();

    result.fold(
      (failure) => emit(AuthenticationError('${failure.statusCode} Error: ${failure.message}'),),
      (List<User> users) => emit(UsersLoaded(users),),
    );
  }
}
