import 'package:equatable/equatable.dart';

class Violation extends Equatable {
  final int id;
  final String violationName;
  final String status;
  final String violationCode;
  final String createdDate;
  final String imageUrl;
  final String description;
  final int regulationId;

  Violation({
    this.id,
    this.violationName,
    this.status,
    this.violationCode,
    this.createdDate,
    this.imageUrl,
    this.description,
    this.regulationId,
  });

  @override
  List<Object> get props => [
        id,
        violationName,
        status,
        violationCode,
        createdDate,
        imageUrl,
        description,
        regulationId
      ];

  static Violation fromJson(dynamic json) {
    return Violation();
  }
}
