import 'package:equatable/equatable.dart';

class Report extends Equatable {
  final int id;
  final String branchId;
  final String name;
  final String description;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String createdBy;

  Report(
      {this.id,
      this.branchId,
      this.name,
      this.description,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.createdBy});

  @override
  List<Object> get props => [name, status];
}
