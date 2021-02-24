part of 'report_bloc.dart';

abstract class ReportEvent extends Equatable {
  const ReportEvent();

  @override
  List<Object> get props => [];
}

class ReportRequested extends ReportEvent {
  const ReportRequested({@required this.token, this.status});

  final String token;
  final String status;

  @override
  List<Object> get props => [token, status];
}
