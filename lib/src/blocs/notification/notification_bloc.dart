import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:capstone_mobile/src/data/models/notification/notification.dart';
import 'package:capstone_mobile/src/data/repositories/notification/notification_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final NotificationRepository notificationRepository;

  NotificationBloc({@required this.notificationRepository})
      : super(NotificationInitial());

  @override
  Stream<NotificationState> mapEventToState(
    NotificationEvent event,
  ) async* {
    try {
      if (event is NotificationRequested) {
        final notifications = await notificationRepository.fetchNotifications(
          sort: 'desc id',
          token: event.token,
        );

        yield NotificationLoadSuccess(notifications: notifications);
      }
    } catch (e) {
      yield NotificationLoadFailure();
    }
  }
}
