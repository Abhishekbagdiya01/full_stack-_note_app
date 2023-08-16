import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:note_app/models/note_model.dart';
import 'package:note_app/models/user_model.dart';

class ServerException implements Exception {
  String errorMessage;
  ServerException({
    required this.errorMessage,
  });
}

class NetworkRepository {
  http.Client client = http.Client();

  String _endPoint(String endpoint) {
    return "http://192.168.29.235:5000/v1/$endpoint";
  }

  Map<String, String> _header = {
    "Content-Type": "application/json; charset=utf-8"
  };

  Future<UserModel> signUp(UserModel userModel) async {
    final encodedParam = jsonEncode(userModel);
    final response = await client.post(Uri.parse(_endPoint("user/signUp")),
        body: encodedParam, headers: _header);

    if (response.statusCode == 200) {
      final userMode =
          UserModel.fromJson(jsonDecode(response.body)['response']);

      return userMode;
    } else {
      throw ServerException(
          errorMessage: jsonDecode(response.body)['response']);
    }
  }

  Future<UserModel> signIn(UserModel userModel) async {
    final encodedParam = jsonEncode(userModel);
    final response = await client.post(Uri.parse(_endPoint("user/signIn")),
        body: encodedParam, headers: _header);

    if (response.statusCode == 200) {
      final userMode =
          UserModel.fromJson(jsonDecode(response.body)['response']);

      return userMode;
    } else {
      throw ServerException(
          errorMessage: jsonDecode(response.body)['response']);
    }
  }

  Future<UserModel> myProfile(UserModel user) async {
    final response = await client.get(
        Uri.parse(_endPoint("user/myProfile?uid=${user.uid}")),
        headers: _header);

    if (response.statusCode == 200) {
      final userModel =
          UserModel.fromJson(jsonDecode(response.body)['response']);

      return userModel;
    } else {
      throw ServerException(
          errorMessage: jsonDecode(response.body)['response']);
    }
  }

  Future<UserModel> updateProfile(UserModel userModel) async {
    final encodedParam = jsonEncode(userModel);
    final response = await client.post(
        Uri.parse(_endPoint("user/updateProfile")),
        headers: _header,
        body: encodedParam);

    if (response.statusCode == 200) {
      final userModel =
          UserModel.fromJson(jsonDecode(response.body)['response']);

      return userModel;
    } else {
      throw ServerException(
          errorMessage: jsonDecode(response.body)['response']);
    }
  }

  Future<List<NoteModel>> fetchMyNotes(NoteModel noteModel) async {
    final response = await client.get(
        Uri.parse(_endPoint("note/getMyNote?uid=${noteModel.creatorId}")),
        headers: _header);

    if (response.statusCode == 200) {
      List<dynamic> note = jsonDecode(response.body)["response"];
      final notesData = note.map((e) => NoteModel.fromJson(e)).toList();

      return notesData;
    } else {
      throw ServerException(
          errorMessage: jsonDecode(response.body)['response']);
    }
  }

  Future addNote(NoteModel noteModel) async {
    final encodedParam = jsonEncode(noteModel);
    final response = await client.post(Uri.parse(_endPoint("note/addNote")),
        headers: _header, body: encodedParam);

    if (response.statusCode == 200) {
      print('success');
    } else {
      throw ServerException(
          errorMessage: jsonDecode(response.body)["response"]);
    }
  }

  Future updateNote(NoteModel noteModel) async {
    final encodedParam = jsonEncode(noteModel);
    final response = await client.put(Uri.parse(_endPoint("note/updateNote")),
        headers: _header, body: encodedParam);

    if (response.statusCode == 200) {
      print(response.body);
    } else {
      throw ServerException(
          errorMessage: jsonDecode(response.body)["response"]);
    }
  }

  Future delateNote(NoteModel noteModel) async {
    final encodedParam = jsonEncode(noteModel);
    final response = await client.delete(
        Uri.parse(_endPoint("note/deleteNote")),
        headers: _header,
        body: encodedParam);

    if (response.statusCode == 200) {
      print(response.body);
    } else {
      throw ServerException(
          errorMessage: jsonDecode(response.body)["response"]);
    }
  }
}
