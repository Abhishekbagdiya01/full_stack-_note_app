part of 'user_cubit.dart';

sealed class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {
  @override
  List<Object> get props => [];
}

class UserLoading extends UserState {
  @override
  List<Object> get props => [];
}

class UserLoaded extends UserState {
  UserModel userModel;
  UserLoaded({
    required this.userModel,
  });
  @override
  List<Object> get props => [userModel];
}

class UserError extends UserState {
  String errorMessage;
  UserError({
    required this.errorMessage,
  });
  @override
  List<Object> get props => [errorMessage];
}
