// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserReviews {
  String username;
  String review;
  int stars;
  String photoURL;
  UserReviews({
    required this.username,
    required this.review,
    required this.stars,
    required this.photoURL,
  });

  UserReviews copyWith({
    String? username,
    String? review,
    int? stars,
    String? photoURL,
  }) {
    return UserReviews(
      username: username ?? this.username,
      review: review ?? this.review,
      stars: stars ?? this.stars,
      photoURL: photoURL ?? this.photoURL,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'review': review,
      'stars': stars,
      'photoURL': photoURL,
    };
  }

  factory UserReviews.fromMap(Map<String, dynamic> map) {
    return UserReviews(
      username: map['username'] as String,
      review: map['review'] as String,
      stars: map['stars'] as int,
      photoURL: map['photoURL'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserReviews.fromJson(String source) => UserReviews.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserReviews(username: $username, review: $review, stars: $stars, photoURL: $photoURL)';
  }

  @override
  bool operator ==(covariant UserReviews other) {
    if (identical(this, other)) return true;
  
    return 
      other.username == username &&
      other.review == review &&
      other.stars == stars &&
      other.photoURL == photoURL;
  }

  @override
  int get hashCode {
    return username.hashCode ^
      review.hashCode ^
      stars.hashCode ^
      photoURL.hashCode;
  }
}
