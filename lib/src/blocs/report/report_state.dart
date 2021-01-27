part of 'report_bloc.dart';

abstract class ReportState extends Equatable {
  const ReportState();

  @override
  List<Object> get props => [];
}

class ReportInitial extends ReportState {}

class ReportLoadInProgress extends ReportState {}

class ReportLoadSuccess extends ReportState {
  final List<String> reports;

  const ReportLoadSuccess({@required this.reports});

  ReportLoadSuccess copyWith({List<String> reports}) {
    return ReportLoadSuccess(reports: reports ?? this.reports);
  }
}

class ReportLoadFailure extends ReportState {}

class ReportCreateState extends ReportState {
  const ReportCreateState({
    this.status = FormzStatus.pure,
    this.reportName = const ReportName.pure(),
  });

  final FormzStatus status;
  final ReportName reportName;

  ReportCreateState copyWith({
    FormzStatus status,
    ReportName reportName,
  }) {
    return ReportCreateState(
      status: status ?? this.status,
      reportName: reportName ?? this.reportName,
    );
  }

  @override
  List<Object> get props => [status, reportName];
}
