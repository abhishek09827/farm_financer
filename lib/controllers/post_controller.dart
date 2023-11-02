import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_storage/firebase_storage.dart';
import '../models/post.dart';
import 'dart:io';

import 'package:path/path.dart';

class PostController {
  Future<String?> uploadFile(File? photo) async {
    if (photo == null) return null;
    print("inside upload 1");
    final fileName = basename(photo.path);
    final destination = 'posts/$fileName';

    try {
      print("inside upload 2");
      final ref = firebaseStorage.ref(destination).child('');
      await ref.putFile(photo);
      String imageURL = await ref.getDownloadURL();
      print(imageURL);
      print("inside upload 3");
      return imageURL;
    } catch (e) {
      print(e.toString());
      print('error occured');
    }
  }

  FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  addPost(users, CommunityPost post) async {
    
    print("indside add data");
    print(users?.uid);
    final doc = await FirebaseFirestore.instance
        .collection('resources')
        .add(post.toMap());
    print("indside add data2");
    // final snapshot = await doc.get();
    // final docs = snapshot.data();

    // addExpense(
    //     res: txtRes.text,
    //     amount: int.parse(amt.text),
    //     date: DateTime.now(),
    //     isIncome: selectedValue,
    //     imgPath: " ");
    // if(selectedValue=="Income"){
    //   doc.update({
    //     'savings': docs?['savings'] + int.parse(amt.text)
    //   });
    // }
    // else{
    //     doc.update({
    //       'savings': docs?['savings'] - int.parse(amt.text)
    //     });
    // }
    // Navigator.push(context, MaterialPageRoute(
    //   builder: (context) => MainTabView(savings: docs?['savings'],),
    // ));
  }
}
