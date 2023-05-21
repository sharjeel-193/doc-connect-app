import 'package:firebase_storage/firebase_storage.dart';

class UserModel {
  // final String id;
  final String email;
  String? name;
  DateTime? dob;
  final bool isVerified;
  String? gender;
  String? profileImgUrl = null;

  UserModel(
      {
      // required this.id,
      required this.email,
      required this.name,
      required this.dob,
      required this.isVerified,
      required this.gender,
      this.profileImgUrl});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        // id: json['id'],
        email: json['email'],
        name: json['name'],
        dob: DateTime.parse(json['dob']),
        isVerified: json['isVerified'],
        gender: json['gender'],
        profileImgUrl: json['profileImgUrl']);
  }

  Map<String, dynamic> toJson() => {
        // 'id': id,
        'email': email,
        'name': name,
        'dob': dob!.toIso8601String(),
        'isVerified': isVerified,
        'gender': gender,
        'profileImgUrl': profileImgUrl
      };

  Future<String?> getProfileImgUrl() async {
    if (profileImgUrl == null) {
      return null;
    }
    try {
      final ref = FirebaseStorage.instance.refFromURL(profileImgUrl!);
      final url = await ref.getDownloadURL();
      return url;
    } catch (e) {
      print('Error getting download URL for profile image: $e');
      return null;
    }
  }
}
