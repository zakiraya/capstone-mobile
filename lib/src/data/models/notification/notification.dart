import 'package:equatable/equatable.dart';

class Notification extends Equatable {
  final bool isRead;
  final String status;
  final int id;
  final String name;
  final String type;
  final String description;
  final int total;

  Notification({
    this.isRead,
    this.status,
    this.id,
    this.name,
    this.type,
    this.description,
    this.total,
  });

  static Notification fromJson(dynamic json) {
    return Notification(
      // isRead: json['isRead'],
      // status: json['status'],
      id: json['id'],
      name: json['name'],
      type: json['type'],
      description: json['description'],
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
      ];
}
