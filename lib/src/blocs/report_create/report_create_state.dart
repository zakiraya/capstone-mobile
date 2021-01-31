part of 'report_create_bloc.dart';

class ReportCreateState extends Equatable {
  const ReportCreateState({
    this.status = FormzStatus.pure,
    this.reportName = const ReportName.pure(),
    this.reportDescription = const ReportDescription.pure(),
  });

  final FormzStatus status;
  final ReportName reportName;
  final ReportDescription reportDescription;

  ReportCreateState copyWith(
      {FormzStatus status,
      ReportName reportName,
      ReportDescription reportDescription}) {
    return ReportCreateState(
        status: status ?? this.status,
        reportName: reportName ?? this.reportName,
        reportDescription: reportDescription ?? this.reportDescription);
  }

  @override
  List<Object> get props => [status, reportName, reportDescription];
}
