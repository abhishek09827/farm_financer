import 'dart:io';
import 'package:farm_financer/screens/resources.dart';
import 'package:farm_financer/util/constants.dart';
import 'package:file_picker/file_picker.dart';
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
  FilePickerResult? result;
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
      backgroundColor: AppColor.black,
      appBar: AppBar(
        backgroundColor: AppColor.deepOrangeAccent,
        title: Text("Add Resource"),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(),
                  SizedBox(
                    width: 12,
                  ),
                  Text(
                    "emma_watson",
                    style: TextStyle(color: AppColor.white),
                  )
                ],
              ),
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
                  height: 300,
                  width: 300,
                  child: image != null
                      ? Image.file(
                          File(image!.path),
                          fit: BoxFit.cover,
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                              Icon(Icons.file_upload_outlined,color: AppColor.deepOrangeAccent,),
                              Text(
                                "Browse Files",
                                style: TextStyle(color: AppColor.deepOrangeAccent),
                              )
                            ]),
                  decoration: BoxDecoration(
                      // color: Colors.grey[300],
                      border: Border.all(color: Colors.white24, width: 1),
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                  autofocus: false,
                  controller: captionController,
                  textAlign: TextAlign.start,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    fillColor: Colors.black,
                    suffixIcon: result != null
                        ? IconButton(
                            onPressed: () async {
                              print("sfdfdf");
                              String? imageURL1 =
                                  await PostController().uploadFile(image);
                              if (imageURL1 == null) {
                                print("could not upload image ");
                                return;
                              }
                              print("sfdfdf");

                              print("sfdfdf");
                              List<String> docLinks = [];
                              for (var element in result!.files) {
                                print(element.name);

                                String? imageURL = await PostController()
                                    .uploadDocuments(element);
                                if (imageURL == null) {
                                  print("could not upload image ");
                                  return;
                                }
                                docLinks.add(imageURL);
                              }
                              print("sfdfdf");
                              CommunityPost post = CommunityPost(
                                  userID: users!.uid!,
                                  photoUrl: imageURL1,
                                  files: docLinks,
                                  caption: captionController.text,
                                  dateTime: DateTime.now(),
                                  likes: 0);
                              bool posted =
                                  await PostController().addPost(users, post);
                              if (posted) {
                                print("POsted");
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ResourcesPage()),
                                );
                              } else
                                print("try ahain");
                            },
                            icon: Icon(
                              Icons.send,
                              color: AppColor.deepOrangeAccent,
                            ))
                        : IconButton(
                            onPressed: () async {
                              final allFiles = await FilePicker.platform
                                  .pickFiles(
                                      type: FileType.custom,
                                      allowedExtensions: ['pdf', 'docx'],
                                      allowMultiple: true);
                              setState(() {
                                result = allFiles;
                              });
                              if (result == null) {
                                print("No file selected");
                              } else {
                                for (var element in result!.files) {
                                  print(element.name);

                                  // PostController().uploadDocuments(element);
                                }
                              }
                            },
                            icon: Icon(
                              Icons.upload,
                              color: AppColor.deepOrangeAccent,
                            )),
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
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 14, horizontal: 16),
                    isDense: true,
                  ),
                  style: TextStyle(
                      color: AppColor.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 14)),
              // ElevatedButton(
              //     onPressed: () async {
              //       print("sfdfdf");
              //       String? imageURL1 =
              //           await PostController().uploadFile(image);
              //       if (imageURL1 == null) {
              //         print("could not upload image ");
              //         return;
              //       }
              //       print("sfdfdf");

              //       print("sfdfdf");
              //       List<String> docLinks = [];
              //       for (var element in result!.files) {
              //         print(element.name);

              //         String? imageURL =
              //             await PostController().uploadDocuments(element);
              //         if (imageURL == null) {
              //           print("could not upload image ");
              //           return;
              //         }
              //         docLinks.add(imageURL);
              //       }
              //       print("sfdfdf");
              //       CommunityPost post = CommunityPost(
              //           userID: users!.uid!,
              //           photoUrl: imageURL1,
              //           files: docLinks,
              //           caption: captionController.text,
              //           dateTime: DateTime.now(),
              //           likes: 0);
              //       bool posted = await PostController().addPost(users, post);
              //       if (posted) {
              //         print("POsted");
              //         Navigator.pushReplacement(
              //           context,
              //           MaterialPageRoute(
              //               builder: (context) => ResourcesPage()),
              //         );
              //       } else
              //         print("try ahain");
              //     },
              //     child: Text(
              //       "Post",
              //       style: TextStyle(color: AppColor.white),
              //     )),
        
              // if (result != null)
              //   Column(
              //     children: [],
              //   )
            ],
          ),
        ),
      ),
    );
  }
}
