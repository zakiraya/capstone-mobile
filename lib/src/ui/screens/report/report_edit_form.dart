import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import 'package:capstone_mobile/src/blocs/report_create/report_create_bloc.dart';
import 'package:capstone_mobile/src/data/models/report/report.dart';
import 'package:capstone_mobile/src/data/models/violation/violation.dart';
import 'package:capstone_mobile/src/ui/screens/violation/violation_screen.dart';
import 'package:capstone_mobile/src/ui/constants/constant.dart';
import 'package:capstone_mobile/generated/l10n.dart';

class ReportEditForm extends StatelessWidget {
  const ReportEditForm({
    Key key,
    @required this.report,
    @required this.theme,
    @required this.descriptionTextFieldController,
    @required this.isEditing,
    @required this.size,
  }) : super(key: key);

  final Report report;
  final ThemeData theme;
  final TextEditingController descriptionTextFieldController;
  final bool isEditing;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16, top: 8, right: 16),
      child: ListView(
        children: [
          Container(
            child: Text(
              '${report.name}',
              style: TextStyle(
                color: theme.primaryColor,
                fontSize: theme.textTheme.headline5.fontSize,
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
                        color: Constant.statusColors[report.status],
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
                Text(report.createdAt ?? 'created on'),
                SizedBox(
                  height: 16,
                ),
                Container(
                  child: Text(S.of(context).UPDATED_ON + ": ",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                Text(report.updatedAt ?? 'created on'),
                SizedBox(
                  height: 16,
                ),
                Container(
                  child: Text(S.of(context).COMMENTS + ": ",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                _ReportDescriptionInput(
                  descriptionTextFieldController:
                      descriptionTextFieldController,
                  report: report,
                  isEditing: isEditing,
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
            height: 16,
          ),
          buildViolationList([
            Violation(branchName: 'fsdf'),
            Violation(branchName: 'fsdf'),
          ]),
          isEditing == false
              ? Container()
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _SaveButton(
                      size: size,
                      report: report,
                    ),
                    _SubmitButton(
                      size: size,
                      report: report,
                    ),
                  ],
                ),
          SizedBox(
            height: 32,
          ),
        ],
      ),
    );
  }
}

class _ReportDescriptionInput extends StatelessWidget {
  const _ReportDescriptionInput({
    Key key,
    @required this.descriptionTextFieldController,
    @required this.report,
    @required this.isEditing,
  }) : super(key: key);

  final TextEditingController descriptionTextFieldController;
  final Report report;
  final bool isEditing;

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
            filled: isEditing,
            fillColor: isEditing ? Colors.grey[400] : null,
            hintText: report.description,
            border: isEditing
                ? OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  )
                : InputBorder.none,
          ),
          onChanged: (description) {
            context.read<ReportCreateBloc>().add(
                  ReportDescriptionChanged(
                    reportDescription: description,
                    isEditing: true,
                  ),
                );
          },
          enabled: isEditing,
          maxLines: isEditing ? 5 : null,
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
            onPressed: state.status.isValidated && state.isEditing == true
                ? () {
                    context.read<ReportCreateBloc>().add(
                          ReportEdited(report: report),
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

class _SaveButton extends StatelessWidget {
  const _SaveButton({
    Key key,
    @required this.size,
    this.report,
  }) : super(key: key);

  final Size size;
  final Report report;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReportCreateBloc, ReportCreateState>(
      buildWhen: (previous, current) => previous.isEditing != current.isEditing,
      builder: (context, state) {
        return Container(
          width: size.width * 0.4,
          child: ElevatedButton(
            key: const Key('reportForm_saveDraft_raisedButton'),
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
                            isDraft: true,
                          ),
                        );

                    Navigator.pop(context);
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

Widget buildViolationList(List<Violation> violations) {
  List<ViolationCard> violationCards = List<ViolationCard>();
  for (var vio in violations) {
    ViolationCard card = ViolationCard(
      violation: vio,
    );
    violationCards.add(card);
  }
  return Column(
    children: [...violationCards],
  );
}
