import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:meta/meta.dart';

import 'package:note_app/utils/shared_pref.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  SharedPref pref = SharedPref();

  void appStart() async {
    String? uid = await pref.getUid();
    try {
      if (uid != null) {
        emit(Authenticated(uid: uid));
      } else {
        emit(UnAuthenticated());
      }
    } catch (_) {
      emit(UnAuthenticated());
    }
  }

  Future loggedIn(String uid) async {
    try {
      pref.setUid(uid);
      emit(Authenticated(uid: uid));
    } catch (_) {
      emit(UnAuthenticated());
    }
  }

  Future loggedOut() async {
    pref.setUid("");
    emit(UnAuthenticated());
  }
}
