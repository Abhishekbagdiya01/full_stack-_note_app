part of 'credential_cubit.dart';

@immutable
abstract class CredentialState extends Equatable {
  const CredentialState();
}

class CredentialInitial extends CredentialState {
  @override
  List<Object?> get props => [];
}

class CredentialLoading extends CredentialState {
  @override
  List<Object?> get props => [];
}

class CredentialSuccess extends CredentialState {
  final UserModel userModel;
  CredentialSuccess({
    required this.userModel,
  });
  @override
  List<Object?> get props => [userModel];
}

class CredentialError extends CredentialState {
  final String errorMessage;
  CredentialError({
    required this.errorMessage,
  });
  @override
  List<Object?> get props => [errorMessage];
}
