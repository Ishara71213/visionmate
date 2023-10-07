import 'package:equatable/equatable.dart';
import 'package:visionmate/core/constants/user_types.dart';

class UserEntity extends Equatable {
  final String? name;
  final String? email;
  final String? uid;
  final String? dob;
  final String? status;
  final String? password;
  final String? userType;

  const UserEntity(
      {this.name,
      this.email,
      this.uid,
      this.dob,
      this.status,
      this.password,
      this.userType});

  @override
  // to compair value equality of an instant
  List<Object?> get props =>
      [name, email, uid, dob, status, password, userType];
}
