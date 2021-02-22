part of 'violation_bloc.dart';

abstract class ViolationEvent extends Equatable {
  const ViolationEvent();

  @override
  List<Object> get props => [];
}

class ViolationRequested extends ViolationEvent {
  const ViolationRequested({@required this.token, this.isRefresh = false});

  final String token;
  final bool isRefresh;

  @override
  List<Object> get props => [token, isRefresh];
}
