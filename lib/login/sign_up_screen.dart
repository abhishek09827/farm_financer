import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm_financer/view/main_tab.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../common/color_extension.dart';

import '../common/primary_button.dart';
import '../models/users.dart';
import '../widgets/round_tf.dart';
import '../widgets/sec_button.dart';
import 'login_screen.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}


class _SignUpViewState extends State<SignUpView> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  TextEditingController txtSavings = TextEditingController();
  TextEditingController score = TextEditingController();

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
              const Spacer(),
              RoundTextField(
                title: "E-mail address",
                controller: txtEmail,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(
                height: 15,
              ),
              RoundTextField(
                title: "Password",
                controller: txtPassword,
                obscureText: true,
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 5,
                      margin: const EdgeInsets.symmetric(horizontal: 1),
                      decoration: BoxDecoration(
                        color: TColor.gray70,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 5,
                      margin: const EdgeInsets.symmetric(horizontal: 1),
                      decoration: BoxDecoration(
                        color: TColor.gray70,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 5,
                      margin: const EdgeInsets.symmetric(horizontal: 1),
                      decoration: BoxDecoration(
                        color: TColor.gray70,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 5,
                      margin: const EdgeInsets.symmetric(horizontal: 1),
                      decoration: BoxDecoration(
                        color: TColor.gray70,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Use 8 or more characters with a mix of letters,\nnumbers & symbols.",
                    style: TextStyle(color: TColor.gray50, fontSize: 12),
                  ),
                ],
              ),const SizedBox(
                height: 15,
              ),
              RoundTextField(
                title: "Current Savings",
                keyboardType: TextInputType.number,
                controller: txtSavings,

              ),
              const SizedBox(
                height: 20,
              ),
              RoundTextField(
                title: "score",
                controller: score,
                obscureText: true,
              ),
              const SizedBox(
                height: 20,
              ),
              PrimaryButton(
                title: "Get started, it's free!",
                onPressed: () async{
                  createUser(
                      email: txtEmail.text,
                      paswd: txtPassword.text,
                      dateJoined: DateTime.now(),
                      savings: int.parse(txtSavings.text),
                    score: double.parse(score.text),
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignInView(),
                    ),
                  );


                }, color: Colors.deepOrangeAccent,
                color2: Colors.orangeAccent,
              ),
              const Spacer(),
              Text(
                "Do you have already an account?",
                textAlign: TextAlign.center,
                style: TextStyle(color: TColor.white, fontSize: 14),
              ),
              const SizedBox(
                height: 20,
              ),
              SecondaryButton(
                title: "Sign in",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignInView(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
  Future createUser ({required String email,required String paswd, required double score,required DateTime dateJoined, required int savings,})async{

    final user = await firebaseAuth.createUserWithEmailAndPassword(email: email, password: paswd);
    print(user.user!.uid);
    final users = UserModel(
        uid: user.user!.uid,
        email: email,
        paswd: paswd ,
        dateJoined: dateJoined,
        savings:savings,
        score: score,
    );
    final json = users.toMap();
    await FirebaseFirestore.instance.collection('users').doc(user.user!.uid).set(json);



  }


}
