import 'package:bloc/bloc.dart';
import 'package:tdd_tutorial/features/authentication/domain/usecases/create_user_use_case.dart';
import 'package:tdd_tutorial/features/authentication/domain/usecases/get_users_use_case.dart';
import 'package:tdd_tutorial/features/authentication/presentation/cubit/authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit({
    required CreateUserUseCase createUser,
    required GetUsersUseCase getUsers,
  }) : _createUser = createUser,
        _getUsers = getUsers,
        super(const AuthenticationInitial());

  final CreateUserUseCase _createUser;
  final GetUsersUseCase _getUsers;

  Future<void> createUser({
    required String createdAt,
    required String name,
    required String avatar,
  }) async {
    emit(const CreatingUser());

    final result = await _createUser(CreateUserParams(
      createdAt: createdAt,
      name: name,
      avatar: avatar,
    ));

    result.fold(
          (failure) => emit(AuthenticationError(failure.message ?? '')),
          (_) => emit(const UserCreated()),
    );
  }


  Future<void> getUsers() async {
    emit(const GettingUsers());
    final result = await _getUsers();

    result.fold(
          (failure) => emit(AuthenticationError(failure.message ?? '')),
          (users) => emit(UsersLoaded(users)),
    );
  }
}

