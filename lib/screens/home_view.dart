import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm_financer/view/main_tab.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../common/color_extension.dart';
import '../models/users.dart';
import '../widgets/custom_arc.dart';
import '../widgets/segment_button.dart';
import '../widgets/settings.dart';
import '../widgets/status_button.dart';
import '../widgets/subs.dart';
import '../widgets/subsInfo.dart';
import '../widgets/upcoming.dart';


class HomeView extends StatefulWidget {
  int? savings = 0;
  HomeView({this.savings, super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}


class _HomeViewState extends State<HomeView> {
  double? end = 270;


  double valuePerDegree = 100000/270;
  int savings = 0;
  User? users=FirebaseAuth.instance.currentUser;
  bool isSubscription = true;
  List subArr = [
    {"name": "Spotify", "icon": "assets/img/spotify_logo.png", "price": "5.99"},
    {
      "name": "YouTube Premium",
      "icon": "assets/img/youtube_logo.png",
      "price": "18.99"
    },
    {
      "name": "Microsoft OneDrive",
      "icon": "assets/img/onedrive_logo.png",
      "price": "29.99"
    },
    {"name": "NetFlix", "icon": "assets/img/netflix_logo.png", "price": "15.00"}
  ];

  List bilArr = [
    {"name": "Spotify", "date": DateTime(2023, 07, 25), "price": "5.99"},
    {
      "name": "YouTube Premium",
      "date": DateTime(2023, 07, 25),
      "price": "18.99"
    },
    {
      "name": "Microsoft OneDrive",
      "date": DateTime(2023, 07, 25),
      "price": "29.99"
    },
    {"name": "NetFlix", "date": DateTime(2023, 07, 25), "price": "15.00"}
  ];
  @override
  Widget build(BuildContext context) {

    var media = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: TColor.gray,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: media.width * 1.1,
              decoration: BoxDecoration(
                  color: TColor.gray70.withOpacity(0.5),
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25))),
              child: Stack(
                alignment: Alignment.center,
                children: [

                  Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Container(
                        padding:  EdgeInsets.only(bottom: media.width * 0.05),
                        width: media.width * 0.72,
                        height: media.width * 0.72,
                        child: CustomPaint(
                          painter: CustomArcPainter(end: end, ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Row(
                          children: [
                            Spacer(),
                            IconButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                          const SettingsView()));
                                },
                                icon: Image.asset("assets/images/settings.png",
                                    width: 25,
                                    height: 25,
                                    color: TColor.gray30))
                          ],
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: media.width * 0.05,
                      ),

                      SizedBox(
                        height: media.width * 0.07,
                      ),
                      FutureBuilder<Map?>(
                        future: readData(),
                        builder: (context,snapshot){
                          if(snapshot.hasData){
                            final data = snapshot.data;

                            return data == null ?
                            Text("₹ 0") : Text(
                             "₹ "+ data['savings'].toString(),

                              style: TextStyle(
                                  color: TColor.white,
                                  fontSize: 40,
                                  fontWeight: FontWeight.w700),
                            );


                          }

                          else{
                            return CircularProgressIndicator();
                          }


                        },

                      ),

                      SizedBox(
                        height: media.width * 0.055,
                      ),

                      Text(
                        "This month bills",
                        style: TextStyle(
                            color: TColor.gray40,
                            fontSize: 12,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: media.width * 0.07,
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: TColor.border.withOpacity(0.15),
                            ),
                            color: TColor.gray60.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            "See your budget",
                            style: TextStyle(
                                color: TColor.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      )
                    ],
                  ),

                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        const Spacer(),
                        Row(
                          children: [
                            Expanded(
                              child: StatusButton(
                                title: "Active subs",
                                value: "12",
                                statusColor: TColor.secondary,
                                onPressed: () {},
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Expanded(
                              child: StatusButton(
                                title: "Highest subs",
                                value: "\$19.99",
                                statusColor: TColor.primary10,
                                onPressed: () {},
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Expanded(
                              child: StatusButton(
                                title: "Lowest subs",
                                value: "\$5.99",
                                statusColor: TColor.secondaryG,
                                onPressed: () {},
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              height: 50,
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(15)),
              child: Row(
                children: [
                  Expanded(
                    child: SegmentButton(
                      title: "Your subscription",
                      isActive: isSubscription,
                      onPressed: () {
                        setState(() {
                          isSubscription = !isSubscription;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: SegmentButton(
                      title: "Upcoming bills",
                      isActive: !isSubscription,
                      onPressed: () {
                        setState(() {
                          isSubscription = !isSubscription;
                        });
                      },
                    ),
                  )
                ],
              ),
            ),

            FutureBuilder<List<Map>?>(
              future: listExpenses().first,
              builder: (context,snapshot){
                final users = snapshot.data;
                print(users?.length);
                if(snapshot.hasData){
                  return  ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: users?.length,
                      itemBuilder: (context, index) {
                        var sObj = users?[index] ?? {};
                        print(sObj["amount"]);

                        return SubScriptionHomeRow(
                          sObj: sObj,
                          onPressed: () {

                            Navigator.push(context, MaterialPageRoute(builder: (context) => SubscriptionInfoView( sObj: sObj ) ));
                          },
                        );
                      });
                }
                else{
                  return CircularProgressIndicator();
                }

              }
            ),

            if (!isSubscription)
              ListView.builder(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: subArr.length,
                  itemBuilder: (context, index) {
                    var sObj = subArr[index] as Map? ?? {};

                    return UpcomingBillRow(
                      sObj: sObj,
                      onPressed: () {},
                    );
                  }),
            const SizedBox(
              height: 110,
            ),
          ],
        ),
      ),
    );

  }
Future<Map?> readData() async{
    print(users?.uid);
    final docUser = FirebaseFirestore.instance.collection("users").doc(users?.uid);
    final snapshot = await docUser.get();
    if(snapshot.exists){
      return snapshot.data();
    }

}

  Stream<List<Map>?> listExpenses() {
    final docUser = FirebaseFirestore.instance.collection("users").doc(users?.uid).collection("expense").snapshots();
    print(docUser.map((event) => event.docs.map((e) => e.data()).toList()));
    return docUser.map((event) => event.docs.map((e) => e.data()).toList());


  }

}

