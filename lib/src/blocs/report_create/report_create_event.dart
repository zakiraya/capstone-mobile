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

class ReportBranchChanged extends ReportCreateEvent {
  const ReportBranchChanged({@required this.reportBranchId});

  final int reportBranchId;

  @override
  List<Object> get props => [reportBranchId];
}

class ReportDescriptionChanged extends ReportCreateEvent {
  const ReportDescriptionChanged({@required this.reportDescription});

  final String reportDescription;

  @override
  List<Object> get props => [reportDescription];
}

class ReportViolationsChanged extends ReportCreateEvent {
  const ReportViolationsChanged({@required this.reportViolation});

  final Violation reportViolation;

  @override
  List<Object> get props => [reportViolation];
}

class ReportViolationRemove extends ReportCreateEvent {
  const ReportViolationRemove({@required this.position});

  final int position;

  @override
  List<Object> get props => [position];
}

class ReportCreateSubmitted extends ReportCreateEvent {
  const ReportCreateSubmitted({this.isDraft = true});

  final bool isDraft;

  @override
  List<Object> get props => [isDraft];
}
