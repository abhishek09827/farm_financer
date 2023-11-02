import 'package:farm_financer/models/post.dart';
import 'package:farm_financer/models/user_reviews.dart';
import 'package:farm_financer/screens/create_post.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CommunityPostPage extends StatelessWidget {
  CommunityPostPage({super.key});

  List<CommunityPost> listofCommunityPost = [
    CommunityPost(
        username: "sarah12",
        url:
            "https://5.imimg.com/data5/SELLER/Default/2022/5/ZY/NG/JQ/55572448/mahindra-jivo-245-di-4wd-tractor-500x500.jpeg",
        photoUrl:
            "https://5.imimg.com/data5/SELLER/Default/2022/5/ZY/NG/JQ/55572448/mahindra-jivo-245-di-4wd-tractor-500x500.jpeg",
        caption: "Hello from India",
        dateTime: DateTime.now(),
        likes: 23),
    CommunityPost(
        username: "sarah12",
        url:
            "https://5.imimg.com/data5/SELLER/Default/2022/5/ZY/NG/JQ/55572448/mahindra-jivo-245-di-4wd-tractor-500x500.jpeg",
        photoUrl:
            "https://5.imimg.com/data5/SELLER/Default/2022/5/ZY/NG/JQ/55572448/mahindra-jivo-245-di-4wd-tractor-500x500.jpeg",
        caption: "Hello from India",
        dateTime: DateTime.now(),
        likes: 23),
  ];
  List<UserReviews> listOfUserReviews = [
    UserReviews(
        username: "sarah12",
        review: "Helloo this is a review",
        stars: 5,
        photoURL:
            "https://5.imimg.com/data5/SELLER/Default/2022/5/ZY/NG/JQ/55572448/mahindra-jivo-245-di-4wd-tractor-500x500.jpeg")
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Community Post"),
        actions: [
          ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => CreatePostScreen()),
                );
              },
              child: Text("Create Post"))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
                shrinkWrap: true,
                // scrollDirection: Axis.vertical,
                itemCount: listofCommunityPost.length,
                itemBuilder: (context, index) {
                  return PostWidget(post: listofCommunityPost[index]);
                }),
            Text("User Reviews"),
            // ListView.builder(
            //     shrinkWrap: true,
            //     scrollDirection: Axis.horizontal,
            //     itemCount: listOfUserReviews.length,
            //     itemBuilder: (context, index) {
            //       return UserReviewWidget(userReview: listOfUserReviews[index]);
            //     }),
          ],
        ),
      ),
    );
  }
}

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
    return Container(
      child: Column(
        children: [
          ListTile(
            title: Text(post.username),
            subtitle: Text(post.dateTime.toString()),
            leading: CircleAvatar(foregroundImage: NetworkImage(post.photoUrl)),
          ),
          Image.network(post.url),
          Text(post.caption),
          Row(
            children: [
              Column(
                children: [
                  Icon(Icons.thumb_up),
                  Text(post.likes.toString()),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
