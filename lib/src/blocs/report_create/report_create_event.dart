part of 'report_create_bloc.dart';

abstract class ReportCreateEvent extends Equatable {
  const ReportCreateEvent();

  @override
  List<Object> get props => [];
}

class ReportNameChanged extends ReportCreateEvent {
  const ReportNameChanged({@required this.reportName});

  final String reportName;

  @override
  List<Object> get props => [reportName];
}

class ReportDescriptionChanged extends ReportCreateEvent {
  const ReportDescriptionChanged({@required this.reportDescription});

  final String reportDescription;

  @override
  List<Object> get props => [reportDescription];
}

class ReportCreateSubmitted extends ReportCreateEvent {
  const ReportCreateSubmitted({this.isDraft = true});

  final bool isDraft;

  @override
  List<Object> get props => [isDraft];
}
