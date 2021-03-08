part of 'notification_bloc.dart';

abstract class NotificationState extends Equatable {
  const NotificationState();

  @override
  List<Object> get props => [];
}

class NotificationInitial extends NotificationState {}

class NotificationLoadInProgress extends NotificationState {}

class NotificationLoadSuccess extends NotificationState {
  final List<Notification> notifications;

  NotificationLoadSuccess({@required this.notifications});

  NotificationLoadSuccess copyWith({
    List<Notification> notifications,
  }) {
    return NotificationLoadSuccess(
        notifications: notifications ?? this.notifications);
  }

  @override
  String toString() =>
      ' NotificationLoadSuccess: { notification total: ${notifications.length} }';
}

class NotificationLoadFailure extends NotificationState {}
