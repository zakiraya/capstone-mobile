import 'package:capstone_mobile/src/data/models/violation/violation.dart';
import 'package:equatable/equatable.dart';

class Report extends Equatable {
  final int id;
  final int branchId;
  final String branchName;
  final String name;
  final String description;
  final String status;
  final String createdAt;
  final String updatedAt;
  final int createdBy;
  final List<Violation> violations;

  Report({
    this.id,
    this.branchId,
    this.branchName,
    this.name,
    this.description,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.createdBy,
    this.violations,
  });

  Map<String, dynamic> toJson() {
    return {
      'createdBy': this.createdBy,
      'branchId': this.branchId,
      'name': this.name,
      'description': this.description,
      'status': this.status
    };
  }

  static Report fromJson(dynamic json) {
    return Report(
      id: json['id'],
      branchId: json['branch']['id'],
      branchName: json['branch']['name'],
      description: json['description'],
      createdAt: json['createdAt'],
      status: json['status'],
    );
  }

  Report copyWith({
    String status,
    String name,
    int branchId,
    int createdBy,
    String description,
  }) {
    return Report(
        status: status ?? this.status,
        branchId: branchId ?? this.branchId,
        createdBy: createdBy ?? this.createdBy,
        name: name ?? this.name,
        description: description ?? this.description);
  }

  @override
  List<Object> get props => [
        name,
        status,
        branchId,
        description,
        createdBy,
      ];
}
