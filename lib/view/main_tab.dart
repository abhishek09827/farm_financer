import 'package:farm_financer/screens/chat_bot.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../common/color_extension.dart';
import '../screens/add_subs.dart';
import '../screens/home_view.dart';


class MainTabView extends StatefulWidget {
  int? savings = 0;
  MainTabView({this.savings,super.key});

  @override
  State<MainTabView> createState() => _MainTabViewState();
}

class _MainTabViewState extends State<MainTabView> {
  int selectTab = 0;
  // PageStorageBucket pageStorageBucket = PageStorageBucket();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
  }

  @override
  Widget build(BuildContext context) {
    Widget child = HomeView();
    switch (selectTab) {
      case 0:
        child = HomeView(savings: widget.savings,);
        break;
      case 1:
        child = HomeView();
        break;

      case 2:
        child = ChatBot();
        break;
    }
    return Scaffold(
      body: Stack(children: [
        child,
        SafeArea(
          child: Column(
            children: [
              const Spacer(),
              Padding(
                padding:
                const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset("assets/images/bottom_bar_bg.png"),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  selectTab = 0;
                                });
                              },
                              icon: Icon(CupertinoIcons.house,color: Colors.white,)
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  selectTab = 1;
                                });
                              },
                              icon: Icon(CupertinoIcons.chat_bubble_2_fill,color: Colors.white,)
                            ),
                            const SizedBox(
                              width: 50,
                              height: 50,
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  selectTab = 2;
                                });
                              },
                              icon: Icon(CupertinoIcons.bubble_middle_bottom_fill,color: Colors.white,)
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  selectTab = 3;
                                });
                              },
                              icon: Icon(CupertinoIcons.profile_circled,color: Colors.white,)
                            ),
                          ],
                        )
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const AddSubs()) );
                      },
                      child: Container(
                        margin: const EdgeInsets.all(20),
                        decoration: BoxDecoration(boxShadow: [
                          BoxShadow(
                              color: TColor.secondary.withOpacity(0.25),
                              blurRadius: 10,
                              offset: const Offset(0, 4))
                        ], borderRadius: BorderRadius.circular(50)),
                        child: Image.asset(
                          "assets/images/center_btn.png",
                          width: 55,
                          height: 55,
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        )
      ]),
    );
  }
}