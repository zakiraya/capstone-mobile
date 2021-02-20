import 'package:capstone_mobile/src/utils/utils.dart';
import 'package:equatable/equatable.dart';

class Violation extends Equatable {
  final int id;
  final String name;
  final String status;
  final String violationCode;
  final String createdAt;
  String imagePath;
  final String description;
  final int regulationId;
  int branchId;
  final branchName;

  Violation({
    this.id,
    this.name,
    this.status,
    this.violationCode,
    this.createdAt,
    this.imagePath,
    this.description,
    this.regulationId,
    this.branchId,
    this.branchName,
  });

  @override
  List<Object> get props => [
        id,
        name,
        status,
        violationCode,
        createdAt,
        imagePath,
        description,
        regulationId,
        branchId,
        branchName,
      ];

  static Violation fromJson(dynamic json) {
    return Violation(
      id: json['id'],
      name: json['name'],
      branchId: json['branch']['id'],
      branchName: json['branch']['name'],
      description: json['description'],
      createdAt: Utils.formatDate(DateTime.parse(json['createdAt'])),
      status: json['status'],
      regulationId: json['regulation']['id'],
      imagePath: json['imagePath'],
    );
  }

  static List<Map<String, dynamic>> convertListViolationToListMap(
      List<Violation> violations) {
    List<Map<String, dynamic>> list = List();

    violations.forEach((violation) {
      list.add(<String, dynamic>{
        'name': 'violation name',
        'description': violation.description,
        'imagePath': violation.imagePath,
        'regulationId': violation.regulationId,
        'branchId': violation.branchId,
      });
    });

    return list;
  }
}
