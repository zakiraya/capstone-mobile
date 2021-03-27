import 'package:capstone_mobile/src/blocs/authentication/authentication_bloc.dart';
import 'package:capstone_mobile/src/blocs/localization/localization_bloc.dart';
import 'package:capstone_mobile/src/blocs/report/report_bloc.dart';
import 'package:capstone_mobile/src/blocs/violation_by_demand/violation_by_demand_bloc.dart';
import 'package:capstone_mobile/src/data/repositories/authentication/authentication_repository.dart';
import 'package:capstone_mobile/src/data/repositories/violation/violation_repository.dart';
import 'package:capstone_mobile/src/ui/widgets/violation/violation_list.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import 'package:capstone_mobile/src/blocs/report_create/report_create_bloc.dart';
import 'package:capstone_mobile/src/data/models/report/report.dart';
import 'package:capstone_mobile/src/ui/constants/constant.dart';
import 'package:capstone_mobile/generated/l10n.dart';
import 'package:intl/intl.dart';

class ReportEditForm extends StatelessWidget {
  const ReportEditForm({
    Key key,
    @required this.report,
    @required this.descriptionTextFieldController,
    @required this.isEditing,
    @required this.size,
  }) : super(key: key);

  final Report report;
  final TextEditingController descriptionTextFieldController;
  final bool isEditing;
  final Size size;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return BlocListener<ReportCreateBloc, ReportCreateState>(
        listener: (context, state) {
          if (state.status.isSubmissionSuccess) {
            Navigator.pop(context);
            CoolAlert.show(
              context: context,
              type: CoolAlertType.success,
              text: S.of(context).SUCCESS,
            ).then((value) {
              BlocProvider.of<ReportBloc>(context).add(
                ReportRequested(
                  isRefresh: true,
                ),
              );
            });
          }
          if (state.status.isSubmissionInProgress) {
            CoolAlert.show(
              barrierDismissible: false,
              context: context,
              type: CoolAlertType.loading,
              text: S.of(context).POPUP_CREATE_VIOLATION_SUBMITTING,
            );
          }
          if (state.status.isSubmissionFailure) {
            Navigator.pop(context);
            CoolAlert.show(
              context: context,
              type: CoolAlertType.error,
              title: "Oops...",
              text: S.of(context).FAIL,
            );
          }
        },
        child: Padding(
          padding: EdgeInsets.only(left: 16, right: 16),
          child: ListView(
            children: [
              Container(
                child: Text(
                  '${report.name}',
                  style: TextStyle(
                    color: theme.primaryColor,
                    fontSize: theme.textTheme.headline5.fontSize,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Text(S.of(context).SUBMITTED_BY + ": "),
                  ),
                  Container(
                      child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: S.of(context).VIOLATION_STATUS + ': ',
                            style: TextStyle(
                              color: Colors.black,
                            )),
                        TextSpan(
                          text: report.status,
                          style: TextStyle(
                            color: Constant.reportStatusColors[report.status],
                          ),
                        ),
                      ],
                    ),
                  )),
                ],
              ),
              Divider(
                color: Colors.black,
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(
                        S.of(context).BRANCH + ':',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(report.branchName ?? 'branch name'),
                    SizedBox(
                      height: 16,
                    ),
                    Container(
                      child: Text(S.of(context).CREATED_ON + ": ",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    Text(DateFormat.yMMMd(
                                BlocProvider.of<LocalizationBloc>(context)
                                    .state)
                            .format(report.createdAt) ??
                        'created on'),
                    SizedBox(
                      height: 16,
                    ),
                    report?.updatedAt != null
                        ? Container(
                            child: Text(S.of(context).UPDATED_ON + ": ",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          )
                        : Container(),
                    report?.updatedAt != null
                        ? Text(DateFormat.yMMMd(
                                BlocProvider.of<LocalizationBloc>(context)
                                    .state)
                            .format(report?.updatedAt))
                        : Container(),
                    SizedBox(
                      height: 16,
                    ),
                    Container(
                      child: Text(
                        S.of(context).DESCRIPTION + ": ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    // _ReportDescriptionInput(
                    //   descriptionTextFieldController:
                    //       descriptionTextFieldController,
                    //   description: report.description,
                    // ),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        minWidth: double.infinity,
                        minHeight: 24,
                      ),
                      child: Container(
                        child: Text(report?.description ?? ''),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Container(
                      child: Text(
                        S.of(context).COMMENTS + ": ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    BlocProvider.of<AuthenticationBloc>(context)
                                .state
                                .user
                                .roleName ==
                            Constant.ROLE_QC
                        ? _ReportQCNote(
                            qcNote: report.qcNote,
                            isEditing: isEditing,
                          )
                        : ConstrainedBox(
                            constraints: BoxConstraints(
                              minWidth: double.infinity,
                              minHeight: 24,
                            ),
                            child: Container(
                              child: Text(report?.qcNote ?? ''),
                            ),
                          ),
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                child: Text(S.of(context).HOME_VIOLATION_LIST + ": ",
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              SizedBox(
                height: 4,
              ),
              BlocProvider(
                create: (context) => ViolationByDemandBloc(
                  authenticationRepository:
                      RepositoryProvider.of<AuthenticationRepository>(context),
                  violationRepository: ViolationRepository(),
                )..add(ViolationRequestedByReportId(reportId: report.id)),
                child: ViolationByReportList(
                  reportId: report.id,
                ),
              ),
              SizedBox(
                height: 32,
              ),
              BlocProvider.of<AuthenticationBloc>(context)
                          .state
                          .user
                          .roleName ==
                      Constant.ROLE_BM
                  ? Container()
                  : report.status.toLowerCase() == 'opening'
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _SaveButton(
                              report: report,
                            ),
                            _SubmitButton(
                              size: size,
                              report: report,
                            ),
                          ],
                        )
                      : Container(),
              SizedBox(
                height: 32,
              ),
            ],
          ),
        ));
  }
}

class _ReportDescriptionInput extends StatelessWidget {
  const _ReportDescriptionInput({
    Key key,
    @required this.descriptionTextFieldController,
    @required this.description,
  }) : super(key: key);

  final TextEditingController descriptionTextFieldController;
  final String description;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReportCreateBloc, ReportCreateState>(
      buildWhen: (previous, current) =>
          previous.reportDescription != current.reportDescription,
      builder: (context, state) {
        return TextField(
          key: const Key('editForm_reportDescription_textField'),
          controller: descriptionTextFieldController,
          decoration: InputDecoration(
            // filled: true,
            // fillColor: Colors.grey[200],
            hintText: description,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide.none,
            ),
          ),
          onChanged: (description) {
            context.read<ReportCreateBloc>().add(
                  ReportDescriptionChanged(
                    reportDescription: description,
                    isEditing: true,
                  ),
                );
          },
          enabled: false,
          maxLines: null,
          style: TextStyle(fontSize: 14),
        );
      },
    );
  }
}

class _ReportQCNote extends StatelessWidget {
  const _ReportQCNote({
    Key key,
    @required this.qcNote,
    @required this.isEditing,
  }) : super(key: key);

  final String qcNote;
  final bool isEditing;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReportCreateBloc, ReportCreateState>(
      buildWhen: (previous, current) =>
          previous.reportDescription != current.reportDescription,
      builder: (context, state) {
        return TextFormField(
          style: TextStyle(fontSize: 14),
          initialValue: qcNote,
          key: const Key('editForm_reportQCNote_textField'),
          decoration: InputDecoration(
            filled: true,
            fillColor: BlocProvider.of<AuthenticationBloc>(context)
                        .state
                        .user
                        .roleName ==
                    Constant.ROLE_QC
                ? Colors.grey[200]
                : Theme.of(context).scaffoldBackgroundColor,
            hintText: qcNote,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide.none,
            ),
          ),
          onChanged: (newValue) {
            context.read<ReportCreateBloc>().add(
                  ReportDescriptionChanged(
                    reportDescription: newValue,
                    isEditing: true,
                  ),
                );
          },
          enabled: BlocProvider.of<AuthenticationBloc>(context)
                  .state
                  .user
                  .roleName !=
              Constant.ROLE_BM,
          maxLines: BlocProvider.of<AuthenticationBloc>(context)
                      .state
                      .user
                      .roleName ==
                  Constant.ROLE_QC
              ? 5
              : null,
        );
      },
    );
  }
}

class _SubmitButton extends StatelessWidget {
  const _SubmitButton({
    Key key,
    @required this.report,
    @required this.size,
  }) : super(key: key);

  final Size size;
  final Report report;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReportCreateBloc, ReportCreateState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return Container(
          width: size.width * 0.4,
          child: ElevatedButton(
            key: const Key('reportForm_submitEdit_raisedButton'),
            child: const Text(
              'Submit',
              style: TextStyle(
                color: Colors.white,
                letterSpacing: 1.5,
              ),
            ),
            onPressed: null,
            style: ElevatedButton.styleFrom(
              onPrimary: Colors.red,
              primary: Theme.of(context).primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _SaveButton extends StatelessWidget {
  const _SaveButton({
    Key key,
    this.report,
  }) : super(key: key);

  final Report report;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return BlocBuilder<ReportCreateBloc, ReportCreateState>(
      buildWhen: (previous, current) => previous.isEditing != current.isEditing,
      builder: (context, state) {
        return Container(
          width: size.width * 0.4,
          child: ElevatedButton(
            key: const Key('reportForm_save_elevatedButton'),
            child: const Text(
              'Save',
              style: TextStyle(
                color: Colors.white,
                letterSpacing: 1.5,
              ),
            ),
            onPressed: state.isEditing == true
                ? () {
                    context.read<ReportCreateBloc>().add(
                          ReportEdited(
                            report: report,
                          ),
                        );
                  }
                : null,
            style: ElevatedButton.styleFrom(
              onPrimary: Colors.red,
              primary: Theme.of(context).primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        );
      },
    );
  }
}
