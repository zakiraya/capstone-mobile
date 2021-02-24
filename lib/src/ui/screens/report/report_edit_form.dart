import 'package:capstone_mobile/src/blocs/report_create/report_create_bloc.dart';
import 'package:capstone_mobile/src/data/models/report/report.dart';
import 'package:capstone_mobile/src/data/models/report/report_list_violation.dart';
import 'package:capstone_mobile/src/data/models/violation/violation.dart';
import 'package:capstone_mobile/src/ui/screens/report/report_violation_list.dart';
import 'package:capstone_mobile/src/ui/screens/report/violation_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

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
              'Report of ${report.name}',
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
                  // child: Text("Created by: ${report.createdBy}"),
                  ),
              Container(
                child: Text("Status: ${report.status}"),
              ),
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
                  child: Text("Branch: "),
                ),
                Text(report.branchName),
                SizedBox(
                  height: 16,
                ),
                Container(
                  child: Text("Created on: "),
                ),
                Text(report.createdAt),
                SizedBox(
                  height: 16,
                ),
                _ReportDescriptionInput(
                  descriptionTextFieldController:
                      descriptionTextFieldController,
                  report: report,
                  editable: isEditing,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Container(
            child: Text("Violation list: "),
          ),
          SizedBox(
            height: 16,
          ),
          ReportListViewViolation(
            isEditing: isEditing,
          ),
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
    @required this.editable,
  }) : super(key: key);

  final TextEditingController descriptionTextFieldController;
  final Report report;
  final bool editable;

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
            fillColor: Colors.grey[400],
            labelText: 'Description: ',
            hintText: report.description,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
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
          enabled: editable,
          maxLines: 5,
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
    ViolationCard card = ViolationCard();
    violationCards.add(card);
  }
  return Column(
    children: [...violationCards],
  );
}
