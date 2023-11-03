import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm_financer/models/post.dart';
import 'package:farm_financer/models/user_reviews.dart';
import 'package:farm_financer/screens/create_post.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CommunityPostPage extends StatelessWidget {
  CommunityPostPage({super.key});

  // List<CommunityPost> listofCommunityPost = [
  //   CommunityPost(
  //       userID: "3we2",
  //       username: "sarah12",
  //       url:
  //           "https://5.imimg.com/data5/SELLER/Default/2022/5/ZY/NG/JQ/55572448/mahindra-jivo-245-di-4wd-tractor-500x500.jpeg",
  //       photoUrl:
  //           "https://5.imimg.com/data5/SELLER/Default/2022/5/ZY/NG/JQ/55572448/mahindra-jivo-245-di-4wd-tractor-500x500.jpeg",
  //       caption: "Hello from India",
  //       dateTime: DateTime.now(),
  //       likes: 23),
  //   CommunityPost(
  //       userID: "cnbsacih",
  //       username: "sarah12",
  //       url:
  //           "https://5.imimg.com/data5/SELLER/Default/2022/5/ZY/NG/JQ/55572448/mahindra-jivo-245-di-4wd-tractor-500x500.jpeg",
  //       photoUrl:
  //           "https://5.imimg.com/data5/SELLER/Default/2022/5/ZY/NG/JQ/55572448/mahindra-jivo-245-di-4wd-tractor-500x500.jpeg",
  //       caption: "Hello from India",
  //       dateTime: DateTime.now(),
  //       likes: 23),
  // ];
  List<UserReviews> listOfUserReviews = [
    UserReviews(
        username: "sarah12",
        review: "Helloo this is a review",
        stars: 5,
        photoURL:
            "https://5.imimg.com/data5/SELLER/Default/2022/5/ZY/NG/JQ/55572448/mahindra-jivo-245-di-4wd-tractor-500x500.jpeg")
  ];

  Future<List<CommunityPost>> fetchResources() async {
    print("fetch 1");
    List<CommunityPost> comm = [];
    print("fetch 2");
    final docUser =
        await FirebaseFirestore.instance.collection("resources").get();
    print(docUser.docs);
    print("fetch 3");
    for (var element in docUser.docs) {
      comm.add(CommunityPost.fromMap(element.data()!));
    }

    print("fetch 4");
    print(comm);
    return comm;
    // final snapshot = await docUser.;
    // if (snapshot.exists) {
    //   return snapshot.data();
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Community Post"),
        actions: [
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CreatePostScreen()),
                );
              },
              child: Text("Create Post"))
        ],
      ),
      body: FutureBuilder(
          future: fetchResources(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }
            return ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return PostWidget(post: snapshot.data![index]);
                });
          }),
    );
  }
}

// ListView.builder(
//     shrinkWrap: true,
//     scrollDirection: Axis.horizontal,
//     itemCount: listOfUserReviews.length,
//     itemBuilder: (context, index) {
//       return UserReviewWidget(userReview: listOfUserReviews[index]);
//     }),
class UserReviewWidget extends StatelessWidget {
  const UserReviewWidget({
    super.key,
    required this.userReview,
  });

  final UserReviews userReview;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey, borderRadius: BorderRadius.circular(12)),
      height: 200,
      width: 100,
      child: Column(
        children: [
          ListTile(
            trailing: Container(
              child: Text(userReview.stars.toString()),
            ),
            title: Text(userReview.username),
            leading: CircleAvatar(
                foregroundImage: NetworkImage(userReview.photoURL)),
          ),
          Text(userReview.review),
          Row(
            children: [
              Column(
                children: [
                  Icon(Icons.thumb_up),
                  // Text(userReview.likes.toString()),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}

class PostWidget extends StatelessWidget {
  const PostWidget({
    super.key,
    required this.post,
  });

  final CommunityPost post;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 8, 15, 8),
          child: Container(
            height: 400,
            // width: MediaQuery.sizeOf(context).width * 0.75,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.green),
                borderRadius: BorderRadius.circular(12)),
            child: Column(
              children: [
                ListTile(
                  title: Text(
                    post.username ?? "unknown",
                    style: TextStyle(color: Colors.red),
                  ),
                  subtitle: Text(post.dateTime.toString()),
                  leading: CircleAvatar(
                      foregroundImage: NetworkImage(post.photoUrl!)),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    post.photoUrl!,
                    height: 75,
                    frameBuilder:
                        (context, child, frame, wasSynchronouslyLoaded) {
                      return Image.asset("assets/images/wp5097914.jpg");
                    },
                    fit: BoxFit.fill,
                    loadingBuilder: (context, child, loadingProgress) {
                      return Image.asset(
                        "assets/images/wp5097914.jpg",
                        height: 250,
                        width: MediaQuery.sizeOf(context).width * .8,
                        fit: BoxFit.fill,
                      );
                      // return CircularProgressIndicator();
                    },
                  ),
                ),
                SizedBox(height: 10,),
                Text(
                  post.caption!,
                ),
                Row(
                  children: [
                    Column(
                      children: [
                        IconButton(onPressed: () {}, icon: Icon(Icons.chat)),
                        // Text(post.likes.toString()),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
