// ignore_for_file: public_member_api_docs, sort_constructors_first
class CommunityPost {
  late String username;
  late String url;
  late String photoUrl;
  late String caption;
  late DateTime dateTime;
  late int likes;
  CommunityPost({
    required this.username,
    required this.url,
    required this.photoUrl,
    required this.caption,
    required this.dateTime,
    required this.likes,
  });
}
