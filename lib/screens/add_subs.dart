import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm_financer/models/expense.dart';
import 'package:farm_financer/view/main_tab.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../common/color_extension.dart';
import '../common/primary_button.dart';
import 'package:image_picker/image_picker.dart';
class AddSubs extends StatefulWidget {
  const AddSubs({super.key});

  @override
  State<AddSubs> createState() => _AddSubsState();
}

class _AddSubsState extends State<AddSubs> {
  User? users=FirebaseAuth.instance.currentUser;
  TextEditingController amt = TextEditingController();
  TextEditingController txtRes = TextEditingController();
  bool isRemember = false;

  List subArr = [
    {"name": "HBO GO", "icon": "assets/img/hbo_logo.png"},
    {"name": "Spotify", "icon": "assets/img/spotify_logo.png"},
    {"name": "YouTube Premium", "icon": "assets/img/youtube_logo.png"},
    {
      "name": "Microsoft OneDrive",
      "icon": "assets/img/onedrive_logo.png",
    },
    {"name": "NetFlix", "icon": "assets/img/netflix_logo.png"}
  ];
  String selectedValue = "Income";

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("Income"), value: "Income"),
      DropdownMenuItem(child: Text("Expense"), value: "Expense"),

    ];
    return menuItems;
  }

  @override
  Widget build(BuildContext context) {
    ImagePicker picker = ImagePicker();
    XFile? image;
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
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  DropdownButton(
                    style: TextStyle(color: Colors.white),
                    dropdownColor: Colors.black38,
                    value: selectedValue,
                    items: dropdownItems,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedValue = newValue!;
                      });
                    },)
                ],
              ),
              Column(
                children: [
                  InkWell(
                    onTap: () async {
                      image =
                      await picker.pickImage(source: ImageSource.gallery);
                    },
                    child: CircleAvatar(
                      radius: 100,
                      child: Icon(Icons.print, size: 200,color: Colors.white,),
                      backgroundColor: Colors.black38,
                    ),
                  ),
                  SizedBox(height: 20,),
                  Text("Upload Invoice").text
                      .color(Colors.white)
                      .bold
                      .make()
                ],
              ),
              const Spacer(),
              VxTextField(
                hint: "Amount (in Rs)",
                hintStyle: TextStyle(
                    color: Vx.gray600
                ),
                controller: amt,
              ),
              const SizedBox(
                height: 15,
              ),
              VxTextField(
                hintStyle: TextStyle(
                    color: Vx.gray600
                ),
                hint: "Resource",
                controller: txtRes,
              ),

              const SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: PrimaryButton(
                  color: Colors.deepOrangeAccent,
                  color2: Colors.orangeAccent,
                  title: "Save",
                  onPressed: () async{
                    final doc = FirebaseFirestore
                        .instance
                        .collection('users')
                        .doc(users?.uid);
                    final snapshot = await doc.get();
                    final docs = snapshot.data();
                    addExpense(
                        res: txtRes.text,
                        amount: int.parse(amt.text),
                        date: DateTime.now(),
                        isIncome: selectedValue,
                        imgPath: " ");
                    if(selectedValue=="Income"){
                      doc.update({
                        'savings': docs?['savings'] + int.parse(amt.text)
                      });
                    }
                    else{
                        doc.update({
                          'savings': docs?['savings'] - int.parse(amt.text)
                        });
                    }
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => MainTabView(savings: docs?['savings'],),
                    ));
                  },
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  Future addExpense({
    required String res,
    required int amount,
    required DateTime date,
    required String isIncome,
    String? imgPath}) async {
    final expense = Expense(
        id: users?.uid,
        resource: res,
        amount: amount,
        date: date,
        isIncome: isIncome,
        imgPath: imgPath
    );
    final json = expense.toMap();
    await FirebaseFirestore
        .instance
        .collection('users')
    .doc(users?.uid)
        .collection(
    "expense").add(json);
  }
  }


