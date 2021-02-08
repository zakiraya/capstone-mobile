import 'package:equatable/equatable.dart';

class Violation extends Equatable {
  final int id;
  final String violationName;
  final String status;
  final String violationCode;
  final String createdDate;
  final String imagePath;
  final String description;
  final int regulationId;
  final int branchId;

  Violation({
    this.id,
    this.violationName,
    this.status,
    this.violationCode,
    this.createdDate,
    this.imagePath,
    this.description,
    this.regulationId,
    this.branchId,
  });

  @override
  List<Object> get props => [
        id,
        violationName,
        status,
        violationCode,
        createdDate,
        imagePath,
        description,
        regulationId,
        branchId,
      ];

  static Violation fromJson(dynamic json) {
    return Violation();
  }
}
