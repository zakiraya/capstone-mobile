import 'package:capstone_mobile/src/utils/utils.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

class Notification extends Equatable {
  final bool isRead;
  final String status;
  final int id;
  final String name;
  final String type;
  final String description;
  final int total;
  final DateTime createdAt;

  Notification({
    this.isRead,
    this.status,
    this.id,
    this.name,
    this.type,
    this.description,
    this.total,
    this.createdAt,
  });

  static Notification fromJson(dynamic json) {
    return Notification(
      isRead: json['isRead'],
      status: json['status'],
      id: json['notification']['id'],
      name: json['notification']['name'],
      type: json['notification']['type'],
      description: json['notification']['description'],
      createdAt: DateTime.parse(json['notification']['createdAt']),
    );
  }

  @override
  List<Object> get props => [
        isRead,
        status,
        id,
        name,
        type,
        description,
        total,
        createdAt,
      ];
}
