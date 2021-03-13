import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:capstone_mobile/src/data/models/notification/notification.dart';
import 'package:capstone_mobile/src/data/repositories/authentication/authentication_repository.dart';
import 'package:capstone_mobile/src/data/repositories/notification/notification_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final NotificationRepository notificationRepository;
  final AuthenticationRepository _authenticationRepository;
  StreamSubscription<AuthenticationStatus> _authenticationStatusSubscription;

  NotificationBloc({
    @required this.notificationRepository,
    @required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(NotificationInitial()) {
    _authenticationStatusSubscription = _authenticationRepository.status.listen(
      (status) => add(NotificationAuthenticationStatusChanged(status: status)),
    );
  }

  @override
  Stream<NotificationState> mapEventToState(
    NotificationEvent event,
  ) async* {
    if (event is NotificationRequested) {
      try {
        final notifications = await notificationRepository.fetchNotifications(
          sort: 'desc id',
          token: _authenticationRepository.token,
        );

        yield NotificationLoadSuccess(notifications: notifications);
      } catch (e) {
        yield NotificationLoadFailure();
      }
    } else if (event is NotificationAuthenticationStatusChanged) {
      if (event.status == AuthenticationStatus.unauthenticated) {
        yield (NotificationInitial());
      } else if (event.status == AuthenticationStatus.authenticated) {
        add(NotificationRequested());
      }
    }
  }
}
