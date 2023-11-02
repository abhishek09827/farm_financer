import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class CommunityPost {
  late String? username;
  late String? url;
  late String photoUrl;
  late String userID;
  late String caption;
  late DateTime dateTime;
  late int likes;
  CommunityPost({
    this.username,
    this.url,
    required this.photoUrl,
    required this.userID,
    required this.caption,
    required this.dateTime,
    required this.likes,
  });

  CommunityPost copyWith({
    String? username,
    String? url,
    String? photoUrl,
    String? userID,
    String? caption,
    DateTime? dateTime,
    int? likes,
  }) {
    return CommunityPost(
      username: username ?? this.username,
      url: url ?? this.url,
      photoUrl: photoUrl ?? this.photoUrl,
      userID: userID ?? this.userID,
      caption: caption ?? this.caption,
      dateTime: dateTime ?? this.dateTime,
      likes: likes ?? this.likes,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'url': url,
      'photoUrl': photoUrl,
      'userID': userID,
      'caption': caption,
      'dateTime': dateTime,
      'likes': likes,
    };
  }

  factory CommunityPost.fromMap(Map<String, dynamic> map) {
    return CommunityPost(
      username: map['username'],
      url: map['url'],
      photoUrl: (map['photoUrl']),
      userID: (map['userID']),
      caption: (map['caption']),
      dateTime: ((map['dateTime'] as Timestamp).toDate()),
      likes: (map['likes']),
    );
  }

  String toJson() => json.encode(toMap());

  factory CommunityPost.fromJson(String source) =>
      CommunityPost.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CommunityPost(username: $username, url: $url, photoUrl: $photoUrl, userID: $userID, caption: $caption, dateTime: $dateTime, likes: $likes)';
  }

  @override
  bool operator ==(covariant CommunityPost other) {
    if (identical(this, other)) return true;

    return other.username == username &&
        other.url == url &&
        other.photoUrl == photoUrl &&
        other.userID == userID &&
        other.caption == caption &&
        other.dateTime == dateTime &&
        other.likes == likes;
  }

  @override
  int get hashCode {
    return username.hashCode ^
        url.hashCode ^
        photoUrl.hashCode ^
        userID.hashCode ^
        caption.hashCode ^
        dateTime.hashCode ^
        likes.hashCode;
  }
}
