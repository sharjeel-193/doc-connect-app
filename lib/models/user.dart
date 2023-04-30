class User {
  final String id;
  final String email;
  final String name;
  final DateTime dob;
  final bool isVerified;

  User(
      {required this.id,
      required this.email,
      required this.name,
      required this.dob,
      required this.isVerified});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      dob: DateTime.parse(json['dob']),
      isVerified: json['isVerified'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'name': name,
        'dob': dob.toIso8601String(),
        'isVerified': isVerified
      };
}
