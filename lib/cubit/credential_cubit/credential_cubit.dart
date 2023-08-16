import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:note_app/models/user_model.dart';
import 'package:note_app/repository/network_repository.dart';

part 'credential_state.dart';

class CredentialCubit extends Cubit<CredentialState> {
  CredentialCubit() : super(CredentialInitial());
  final networkRepository = NetworkRepository();
  Future signUp(UserModel userModel) async {
    try {
      emit(CredentialLoading());
      final userData = await networkRepository.signUp(userModel);

      emit(CredentialSuccess(userModel: userData));
    } on ServerException catch (e) {
      emit(CredentialError(errorMessage: e.errorMessage));
    }
  }

  Future signIn(UserModel userModel) async {
    try {
      emit(CredentialLoading());
      final userData = await networkRepository.signIn(userModel);
      print(userData.uid);
      emit(CredentialSuccess(userModel: userData));
    } on ServerException catch (e) {
      emit(CredentialError(errorMessage: e.errorMessage));
    }
  }
}
