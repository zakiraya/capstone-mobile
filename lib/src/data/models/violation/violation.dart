import 'package:capstone_mobile/src/utils/utils.dart';
import 'package:equatable/equatable.dart';

class Violation extends Equatable {
  final int id;
  final String name;
  final String status;
  final String violationCode;
  final DateTime createdAt;
  String imagePath;
  final String description;
  final int regulationId;
  final String regulationName;
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
    this.regulationName,
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
        regulationName,
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
      createdAt: DateTime.parse(json['createdAt']),
      status: json['status'],
      regulationId: json['regulation']['id'],
      regulationName: json['regulation']['name'],
      imagePath: json['imagePath'],
    );
  }

  Violation copyWith({
    DateTime createdAt,
    int id,
    String name,
    String imagePath,
    String description,
    int regulationId,
    String regulationName,
    int branchId,
    String branchName,
    String status,
  }) {
    return Violation(
      branchId: branchId ?? this.branchId,
      branchName: branchName ?? this.branchName,
      createdAt: this.createdAt,
      description: description ?? this.description,
      id: this.id,
      imagePath: imagePath ?? this.imagePath,
      name: name ?? this.name,
      regulationId: regulationId ?? this.regulationId,
      regulationName: regulationName ?? this.regulationName,
      status: status ?? this.status,
      violationCode: this.violationCode,
    );
  }

  static List<Map<String, dynamic>> convertListViolationToListMap(
      List<Violation> violations) {
    List<Map<String, dynamic>> list = List();

    violations.forEach((violation) {
      list.add(<String, dynamic>{
        // 'name': 'name',
        'description': violation.description,
        'imagePath': violation.imagePath,
        'regulationId': violation.regulationId,
        'branchId': violation.branchId,
      });
    });

    return list;
  }
}
