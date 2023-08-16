import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/cubit/credential_cubit/credential_cubit.dart';
import 'package:note_app/cubit/note_cubit/note_cubit.dart';
import 'package:note_app/cubit/user_cubit/user_cubit.dart';

import 'package:note_app/presentation/screens/user_onboarding/splash_screen.dart';
import 'package:note_app/route/on_generated_routes.dart';

import 'cubit/auth_cubit/auth_cubit.dart';

void main() async {
  runApp(MultiBlocProvider(providers: [
    BlocProvider<AuthCubit>(create: (context) => AuthCubit()..appStart()),
    BlocProvider<CredentialCubit>(create: (context) => CredentialCubit()),
    BlocProvider<UserCubit>(create: (context) => UserCubit()),
    BlocProvider<NoteCubit>(create: (context) => NoteCubit())
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Colors.deepPurple.shade500),
        useMaterial3: false,
      ),
      onGenerateRoute: OnGeneratedRoutes.route,
      routes: {
        "/": (context) {
          // return BlocBuilder<AuthCubit, AuthState>(
          //     builder: (context, authState) {
          //   print("is working now ?");
          //   if (authState is Authenticated) {
          //     if (authState.uid == "") {
          //       return LoginScreen();
          //     } else {
          //       return HomeScreen(
          //         uid: authState.uid,
          //       );
          //     }
          //   } else {
          //     return LoginScreen();
          //   }
          // });
          return SplashScreen();
        }
      },
    );
  }
}
