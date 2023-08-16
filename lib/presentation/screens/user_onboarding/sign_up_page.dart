import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/cubit/auth_cubit/auth_cubit.dart';
import 'package:note_app/cubit/credential_cubit/credential_cubit.dart';
import 'package:note_app/models/user_model.dart';
import 'package:note_app/presentation/screens/user_onboarding/sign_in_page.dart';
import 'package:note_app/presentation/widgets/input_field.dart';
import 'package:note_app/presentation/widgets/snackbar.dart';
import 'package:note_app/route/page_const.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController usernameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Create account',
                style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple),
              ),
              InputField(
                controller: usernameController,
                color: Colors.grey,
                hintText: "Username",
                icon: Icons.person,
              ),
              InputField(
                controller: emailController,
                color: Colors.grey,
                hintText: "Email",
                icon: Icons.email,
              ),
              InputField(
                controller: passwordController,
                obscureText: isVisible ? false : true,
                suffixIcon: isVisible ? Icons.visibility : Icons.visibility_off,
                color: Colors.grey,
                hintText: "password",
                icon: Icons.lock,
                voidCallback: () {
                  isVisible = !isVisible;
                  setState(() {});
                },
              ),
              SizedBox(
                height: 10,
              ),
              BlocConsumer<CredentialCubit, CredentialState>(
                listener: (context, state) {
                  if (state is CredentialSuccess) {
                    BlocProvider.of<AuthCubit>(context)
                        .loggedIn(state.userModel.uid.toString());
                    snackbarMessenger(context, "Account created successfully");
                    Navigator.pushReplacementNamed(context, PageConst.homePage);
                  } else if (state is CredentialError) {
                    snackbarMessenger(context, state.errorMessage);
                  }
                },
                builder: (context, state) {
                  if (state is CredentialLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    return ElevatedButton(
                      onPressed: () {
                        UserModel userModel = UserModel(
                            uid: "",
                            email: emailController.text,
                            username: usernameController.text,
                            password: passwordController.text);
                        BlocProvider.of<CredentialCubit>(context)
                            .signUp(userModel);
                      },
                      child: Text("Sign-Up"),
                    );
                  }
                },
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text("Already have an account ?"),
                  SizedBox(
                    width: 5,
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ));
                      },
                      child: Text(
                        "Login",
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
