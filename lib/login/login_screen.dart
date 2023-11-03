import 'package:farm_financer/login/sign_up_screen.dart';
import 'package:farm_financer/screens/home_view.dart';
import 'package:farm_financer/view/main_tab.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../common/color_extension.dart';
import '../common/primary_button.dart';


class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  bool isRemember = false;
  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: TColor.gray,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Image.asset("assets/img/app_logo.png",
              //     width: media.width * 0.5, fit: BoxFit.contain),
              const Spacer(),
              VxTextField(
                hint: "Login",
                hintStyle: TextStyle(
                  color: Vx.gray600
                ),
                controller: txtEmail,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(
                height: 15,
              ),
              VxTextField(
                hintStyle: TextStyle(
                    color: Vx.gray600
                ),
                hint: "Password",
                controller: txtPassword,
                obscureText: true,
              ),

              const SizedBox(
                height: 8,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        isRemember = !isRemember;
                      });
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          isRemember
                              ? Icons.check_box_rounded
                              : Icons.check_box_outline_blank_rounded,
                          size: 25,
                          color: TColor.gray50,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          "Remember me",
                          style: TextStyle(color: TColor.gray50, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "Forgot password",
                      style: TextStyle(color: TColor.gray50, fontSize: 14),
                    ),
                  ),
                ],
              ),

              const SizedBox(
                height: 8,
              ),

              PrimaryButton(
              color: Colors.deepOrangeAccent,
                  color2: Colors.orangeAccent,
                title: "Sign In",
                onPressed: logInToFb,
              ),
              const Spacer(),
              Text(
                "if you don't have an account yet?",
                textAlign: TextAlign.center,
                style: TextStyle(color: TColor.white, fontSize: 14),
              ),
              const SizedBox(
                height: 20,
              ),
              PrimaryButton(
                  color: Colors.deepOrangeAccent,
                  color2: Colors.black38,
                title: "Sign up",
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => SignUpView()),
                  );

                },
              ),
            ],
          ),
        ),
      ),
    );
  }
  void logInToFb() {
    firebaseAuth
        .signInWithEmailAndPassword(
        email: txtEmail.text, password: txtPassword.text)
        .then((result) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainTabView()),
      );
    }).catchError((err) {
      print(err.message);
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Error"),
              content: Text(err.message),
              actions: [
                TextButton(
                  child: Text("Ok"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    });
  }
}
