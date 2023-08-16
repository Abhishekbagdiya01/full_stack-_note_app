class UserModel {
  String? uid;
  String? username;
  String? password;
  String? email;
  UserModel({this.uid, this.username, this.email, this.password});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        uid: json['_id'],
        username: json['username'],
        email: json['email'],
        password: json['password']);
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'username': username,
      'email': email,
      'password': password,
    };
  }
}
