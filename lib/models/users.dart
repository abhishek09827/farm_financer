class UserModel {
  final String uid;
  final String? name;
  final String email;
  final String paswd;
  final String? profilePic;
  final DateTime dateJoined;
  final int savings;

  UserModel({
    required this.uid,
    this.name,
    required this.email,
    this.profilePic,
    required this.dateJoined,
    required this.savings,
    required this.paswd,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'profilePic': profilePic,
      'dateJoined': dateJoined,
      'savings' : savings,
      'paswd' : paswd
    };
  }

  static UserModel fromMap(Map<String, dynamic>? map) {
    return UserModel(
      uid: map?['uid'],
      name: map?['name'],
      email: map?['email'],
      profilePic: map?['profilePic'],
      dateJoined: map?['dateJoined'],
      savings: map?['savings'],
      paswd: map?['paswd'],
    );
  }
}