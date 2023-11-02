import 'dart:io';

import 'package:farm_financer/controllers/post_controller.dart';
import 'package:farm_financer/models/post.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CreatePostScreen extends StatefulWidget {
  CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  User? users = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    image = null;
    print(users.toString());
  }

  TextEditingController captionController = TextEditingController();

  ImagePicker picker = ImagePicker();

  File? image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Community Post"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            GestureDetector(
              onTap: () async {
                final pickedFile =
                    await picker.pickImage(source: ImageSource.gallery);
                setState(() {
                  if (pickedFile != null) {
                    image = File(pickedFile.path);
                    // uploadFile();
                  } else {
                    print('No image selected.');
                  }
                });
                print(image);
              },
              child: Container(
                height: 200,
                width: 300,
                child: image != null
                    ? Image.file(
                        File(image!.path),
                        fit: BoxFit.cover,
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                            Icon(Icons.file_upload_outlined),
                            Text("Browse Files")
                          ]),
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    border: Border.all(color: Colors.black, width: 1),
                    borderRadius: BorderRadius.circular(12)),
              ),
            ),
            TextFormField(
                autofocus: false,
                controller: captionController,
                textAlign: TextAlign.start,
                keyboardType: TextInputType.phone,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  fillColor: Colors.black,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 1,
                    ),
                  ),
                  // prefixIcon: Padding(
                  //   padding: const EdgeInsets.only(top: 14).r,
                  //   child: Text(
                  //     StringCons.rupee,
                  //     textAlign: TextAlign.center,
                  //     style: TextStyle(
                  //         fontFamily: Cons.appTextStyle,
                  //         color: Colors.appTextColorHeading,
                  //         fontWeight: FontWeight.w600,
                  //         fontSize: 14.h),
                  //   ),
                  // ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                  isDense: true,
                ),
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 14)),
            ElevatedButton(
                onPressed: () async {
                  print("sfdfdf");
                  String? imageURL = await PostController().uploadFile(image);
                  if (imageURL == null) {
                    print("could not upload image ");
                    return;
                  }
                  print("sfdfdf");
                  CommunityPost post = CommunityPost(
                      userID: users!.uid!,
                      photoUrl: imageURL,
                      caption: captionController.text,
                      dateTime: DateTime.now(),
                      likes: 0);
                  PostController().addPost(users, post);
                },
                child: Text("Post"))
          ],
        ),
      ),
    );
  }
}
