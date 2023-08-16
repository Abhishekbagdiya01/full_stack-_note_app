import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:note_app/models/user_model.dart';
import 'package:note_app/repository/network_repository.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());
  NetworkRepository networkRepository = NetworkRepository();

  Future myProfile(UserModel userModel) async {
    try {
      emit(UserLoading());
      final userInfo = await networkRepository.myProfile(userModel);

      emit(UserLoaded(userModel: userInfo));
    } catch (e) {
      emit(UserError(errorMessage: e.toString()));
    }
  }

  Future updateProfile(UserModel userModel) async {
    try {
      emit(UserLoading());
      final userInfo = await networkRepository.updateProfile(userModel);

      emit(UserLoaded(userModel: userInfo));
    } catch (e) {
      emit(UserError(errorMessage: e.toString()));
    }
  }
}
