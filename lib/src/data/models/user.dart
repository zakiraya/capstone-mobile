import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    this.roleName,
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
  final String roleName;
  final int branchId;
  final int branchManagerId;

  @override
  List<Object> get props => [id, email, firstName];

  String get fullName => firstName + ' ' + lastName;

  static const empty = User(firstName: "empty");

  static User fromJson(dynamic json) {
    final userInfo = json['data'];
    return User(
      email: userInfo['email'],
      code: userInfo['code'],
      firstName: userInfo['firstName'],
      lastName: userInfo['lastName'],
      address: userInfo['address'],
      imagePath: userInfo['imagePath'],
      roleName: userInfo['account']['role']['name'],
      branchName:
          userInfo['branch'] == null ? null : userInfo['branch']['name'],
    );
  }
}
