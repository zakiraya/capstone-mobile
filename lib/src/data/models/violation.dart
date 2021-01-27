import 'package:equatable/equatable.dart';

class Violation extends Equatable {
  final int id;
  final int violationName;
  final String status;
  final String violationCode;
  final DateTime violationDate;
  final String imageUrl;

  Violation(
      {this.id,
      this.violationName,
      this.status,
      this.violationCode,
      this.violationDate,
      this.imageUrl});

  @override
  List<Object> get props =>
      [id, violationName, status, violationCode, violationDate, imageUrl];

  static Violation fromJson(dynamic json) {
    return Violation();
  }
}
