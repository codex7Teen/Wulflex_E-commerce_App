class UserModel {
  final String uid;
  final String name;
  final String email;
  final String? dob;
  final String? phoneNumber;
  final String? userImage;

  UserModel(
      {required this.uid,
      required this.name,
      required this.email,
      this.dob,
      this.phoneNumber,
      this.userImage});

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
        uid: map['uid'],
        name: map['name'],
        email: map['email'],
        dob: map['dob'],
        phoneNumber: map['phoneNumber'],
        userImage: map['userImage']);
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'dob': dob,
      'phoneNumber': phoneNumber,
      'userImage': userImage
    };
  }
}
