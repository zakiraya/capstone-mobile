import 'package:capstone_mobile/src/data/models/violation/violation.dart';
import 'package:equatable/equatable.dart';

class Report extends Equatable {
  final int id;
  final int branchId;
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
    this.name,
    this.description,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.createdBy,
    this.violations,
  });

  @override
  List<Object> get props =>
      [name, status, branchId, description, createdAt, createdBy];
}
