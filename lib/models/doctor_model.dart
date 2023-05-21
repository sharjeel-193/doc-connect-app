import 'file_model.dart';
import 'user_model.dart';

class DoctorModel {
  UserModel user;
  String clinicTitle;
  String clinicLocation;
  String description;
  String doctorType;
  List<String> qualifications;

  DoctorModel({
    required this.user,
    required this.clinicTitle,
    required this.clinicLocation,
    required this.description,
    required this.doctorType,
    required this.qualifications,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      user: UserModel.fromJson(json['user']),
      clinicTitle: json['clinicTitle'],
      clinicLocation: json['clinicLocation'],
      description: json['description'],
      doctorType: json['doctorType'],
      qualifications: List<String>.from(json['qualifications']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user.toJson(),
      'clinicTitle': clinicTitle,
      'clinicLocation': clinicLocation,
      'description': description,
      'doctorType': doctorType,
      'qualifications': qualifications,
    };
  }
}
