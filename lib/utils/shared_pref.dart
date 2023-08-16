import 'package:shared_preferences/shared_preferences.dart';

const String currentUSerId = "currentUSerId";

class SharedPref {
  void setUid(String uid) async {
    final pref = await SharedPreferences.getInstance();
    pref.setString(currentUSerId, uid);
  }

  Future<String?> getUid() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString(currentUSerId);
  }
}
