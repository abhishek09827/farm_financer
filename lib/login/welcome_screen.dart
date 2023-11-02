import 'package:farm_financer/common/color_extension.dart';
import 'package:farm_financer/login/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../common/primary_button.dart';
import 'login_screen.dart';
class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              "assets/images/wp5097914.jpg",
              width: MediaQuery.sizeOf(context).width,
              height: MediaQuery.sizeOf(context).height,
            fit: BoxFit.cover,),
            SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                        "assets/images/farm_logo.png",
                        width: MediaQuery.sizeOf(context).width * 0.5,
                        height: MediaQuery.sizeOf(context).height * 0.5),
                    Container(
                      child: Column(
                        children: [
                          PrimaryButton(
                            color: Colors.deepOrange,
                            color2: Colors.deepOrange,
                            title: "Get In",
                            onPressed: (){
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) => SignUpView(),
                              ));
                            },).p(15),
                          PrimaryButton(
                            color: Colors.black38,
                            color2: Colors.black,
                            title: "I Have An Account",
                            onPressed: (){
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) => SignInView(),
                              ));
                            },).p(15)
                        ],
                      ),
                    )

                  ],
                )
                    
            )
          ],
        ),
      ),
    );
  }
}
