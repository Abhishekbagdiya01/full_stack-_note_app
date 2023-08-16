import 'package:flutter/material.dart';
import 'package:note_app/models/note_model.dart';

import 'package:note_app/presentation/screens/add_note_page.dart';
import 'package:note_app/presentation/screens/edit_note_page.dart';
import 'package:note_app/presentation/screens/home_page.dart';
import 'package:note_app/presentation/screens/view_note_page.dart';
import 'package:note_app/route/page_const.dart';
import 'package:note_app/utils/const.dart';

import '../presentation/screens/user_onboarding/sign_in_page.dart';
import '../presentation/screens/user_onboarding/sign_up_page.dart';

class OnGeneratedRoutes {
  static Route<dynamic> route(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case PageConst.signUpPage:
        {
          return MaterialPageRoute(builder: (_) => SignUpScreen());
        }
      case PageConst.signInPage:
        {
          return MaterialPageRoute(builder: (_) => LoginScreen());
        }
      case PageConst.homePage:
        {
          return MaterialPageRoute(
              builder: (_) => HomeScreen(
                    uid: args as String,
                  ));
        }
      case PageConst.addNotePage:
        {
          return MaterialPageRoute(
              builder: (_) => AddNoteScreen(
                    uid: args as String,
                  ));
        }
      case PageConst.viewNotePage:
        {
          if (args is List<dynamic>) {
            return MaterialPageRoute(
                builder: (_) => ViewNoteScreen(
                      noteModel: args[0],
                      color: args[1],
                    ));
          } else {
            return MaterialPageRoute(
              builder: (_) => ErrorPage(),
            );
          }
        }
      case PageConst.updateNotePage:
        {
          return MaterialPageRoute(
              builder: (_) => UpdateNoteScreen(
                    noteModel: args as NoteModel,
                    color: args as Color,
                  ));
        }
      default:
        {
          return MaterialPageRoute(
            builder: (_) => ErrorPage(),
          );
        }
    }
  }
}

class ErrorPage extends StatelessWidget {
  const ErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("error"),
      ),
      body: Center(
        child: Text("error"),
      ),
    );
  }
}
