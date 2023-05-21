class UserModel {
  final String id;
  final String email;
  final String name;
  final DateTime dob;
  final bool isVerified;
  final String gender;
  // final String profileImgUrl = ;

  UserModel({
    required this.id,
    required this.email,
    required this.name,
    required this.dob,
    required this.isVerified,
    required this.gender,
    // this.profileImgUrl
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      dob: DateTime.parse(json['dob']),
      isVerified: json['isVerified'],
      gender: json['gender'],
      // profileImgUrl: json['profileImgUrl']
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'name': name,
        'dob': dob.toIso8601String(),
        'isVerified': isVerified,
        'gender': gender,
        // 'profileImgUrl': profileImgUrl
      };
}
