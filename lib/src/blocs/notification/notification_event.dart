part of 'notification_bloc.dart';

abstract class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object> get props => [];
}

class NotificationRequested extends NotificationEvent {
  final String token;

  NotificationRequested({@required this.token});
  @override
  List<Object> get props => [token];

  @override
  String toString() => ' NotificationRequested ';
}
