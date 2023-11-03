// import 'dart:convert';
// import 'package:cloud_firestore/cloud_firestore.dart';

// // ignore_for_file: public_member_api_docs, sort_constructors_first
// class CommunityPost {
//   late String? username;
//   late String? url;
//   late String photoUrl;
//   late String userID;
//   late String caption;
//   late DateTime dateTime;
//   late int likes;
//   late List<String> files;
//   CommunityPost({
//     this.username,
//     this.url,
//     required this.photoUrl,
//     required this.userID,
//     required this.caption,
//     required this.dateTime,
//     required this.likes,
//     required this.files,
//   });

//   CommunityPost copyWith({
//     String? username,
//     String? url,
//     String? photoUrl,
//     String? userID,
//     String? caption,
//     DateTime? dateTime,
//     int? likes,
//     List<String>? files,
//   }) {
//     return CommunityPost(
//       username: username ?? this.username,
//       url: url ?? this.url,
//       photoUrl: photoUrl ?? this.photoUrl,
//       userID: userID ?? this.userID,
//       caption: caption ?? this.caption,
//       dateTime: dateTime ?? this.dateTime,
//       likes: likes ?? this.likes,
//       files: files ?? this.files,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'username': username,
//       'url': url,
//       'photoUrl': photoUrl,
//       'userID': userID,
//       'caption': caption,
//       'dateTime': dateTime,
//       'likes': likes,
//       'files': files,
//     };
//   }

//   factory CommunityPost.fromMap(Map<String, dynamic> map) {
//     return CommunityPost(
//       username: map['username'] ?? "username",
//       url: map['url'] ?? "url",
//       photoUrl: map['photoUrl'],
//       userID: map['userID'],
//       caption: map['caption'],
//       dateTime: (map['dateTime'] as Timestamp).toDate(),
//       likes: map['likes'],
//       files: map['files'],
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory CommunityPost.fromJson(String source) =>
//       CommunityPost.fromMap(json.decode(source) as Map<String, dynamic>);

//   @override
//   String toString() {
//     return 'CommunityPost(username: $username, url: $url, photoUrl: $photoUrl, userID: $userID, caption: $caption, dateTime: $dateTime, likes: $likes, files: $files)';
//   }

//   @override
//   bool operator ==(covariant CommunityPost other) {
//     if (identical(this, other)) return true;

//     return other.username == username &&
//         other.url == url &&
//         other.photoUrl == photoUrl &&
//         other.userID == userID &&
//         other.caption == caption &&
//         other.dateTime == dateTime &&
//         other.likes == likes &&
//         other.files == files;
//   }

//   @override
//   int get hashCode {
//     return username.hashCode ^
//         url.hashCode ^
//         photoUrl.hashCode ^
//         userID.hashCode ^
//         caption.hashCode ^
//         dateTime.hashCode ^
//         likes.hashCode ^
//         files.hashCode;
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';

class CommunityPost {
  String? photoUrl;
  String? url;
  String? username;
  int? likes;
  String? userID;
  String? caption;
  DateTime? dateTime;
  List<String>? files;

  CommunityPost(
      {this.photoUrl,
      this.url,
      this.username,
      this.likes,
      this.userID,
      this.caption,
      this.dateTime,
      this.files});

  CommunityPost.fromMap(Map<String, dynamic> json) {
    photoUrl = json['photoUrl'];
    url = json['url'];
    username = json['username'];
    likes = json['likes'];
    userID = json['userID'];
    caption = json['caption'];
    dateTime = (json['dateTime'] as Timestamp).toDate();
    files = json['files'].cast<String>();
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['photoUrl'] = photoUrl;
    data['url'] = url;
    data['username'] = username;
    data['likes'] = likes;
    data['userID'] = userID;
    data['caption'] = caption;
    data['dateTime'] = dateTime;
    data['files'] = files;
    return data;
  }
}
