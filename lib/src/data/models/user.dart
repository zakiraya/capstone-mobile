import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    this.roleId,
    this.branchId,
    this.branchManagerId,
    this.firstName,
    this.lastName,
    this.imagePath,
    this.positionId,
    this.branchName,
    this.code,
    this.address,
    this.status,
    this.email,
    this.id,
  });

  final String id;
  final String email;
  final String code;
  final String firstName;
  final String lastName;
  final String address;
  final String status;
  final String imagePath;
  final int positionId;
  final String branchName;
  final int roleId;
  final int branchId;
  final int branchManagerId;

  @override
  List<Object> get props => [id, email, firstName];

  String get fullName => firstName + lastName;

  static const empty = User(firstName: "empty");

  static User fromJson(dynamic json) {
    final data = json['data'];
    final userInfo = data['employee'];
    // final token = json['token'];
    return User(
      email: userInfo['email'],
      code: userInfo['code'],
      firstName: userInfo['first_name'],
      lastName: userInfo['last_name'],
      address: userInfo['address'],
      branchName: userInfo['branch_Name'],
      imagePath: userInfo['image_path'],
      positionId: userInfo['position_id'] as int,
      branchId: userInfo['branch_id'] as int,
      branchManagerId: userInfo['branch_manager_id'] as int,
      roleId: userInfo['role_id'] as int,
      status: userInfo['status'],
    );
  }
}
