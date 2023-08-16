import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/cubit/auth_cubit/auth_cubit.dart';
import 'package:note_app/route/page_const.dart';

import 'package:note_app/utils/const.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    BlocProvider.of<AuthCubit>(context).appStart();

    // Timer(Duration(milliseconds: 300), () {

    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocListener<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is Authenticated) {
                  if (state.uid == "") {
                    Navigator.pushReplacementNamed(
                        context, PageConst.signInPage);
                  } else {
                    Navigator.pushReplacementNamed(context, PageConst.homePage,
                        arguments: state.uid);
                  }
                } else {
                  Navigator.pushReplacementNamed(context, PageConst.signInPage);
                }
              },
              child: CircleAvatar(
                radius: 60,
                backgroundColor: blackColor.withOpacity(0.8),
                backgroundImage: AssetImage("assets/images/app_logo.png"),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text("Note App")
          ],
        ),
      ),
    );
  }
}
