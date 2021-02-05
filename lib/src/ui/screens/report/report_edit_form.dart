import 'package:capstone_mobile/src/blocs/report_create/report_create_bloc.dart';
import 'package:capstone_mobile/src/data/models/report/report.dart';
import 'package:capstone_mobile/src/data/models/violation/violation.dart';
import 'package:capstone_mobile/src/ui/screens/report/violation_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReportEditForm extends StatelessWidget {
  const ReportEditForm({
    Key key,
    @required this.report,
    @required this.theme,
    @required this.descriptionTextFieldController,
    @required this.editable,
    @required this.size,
  }) : super(key: key);

  final Report report;
  final ThemeData theme;
  final TextEditingController descriptionTextFieldController;
  final bool editable;
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
                    editable: editable),
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
          buildViolationList([
            Violation(id: 1),
            Violation(id: 1),
            Violation(id: 1),
            Violation(id: 1),
          ]),
          editable == false
              ? Container()
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _SaveButton(size: size),
                    _SubmitButton(size: size),
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
            context.read<ReportCreateBloc>().add(ReportDescriptionChanged(
                  reportDescription: description,
                ));
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
    @required this.size,
  }) : super(key: key);

  final Size size;

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
            onPressed: () {},
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
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReportCreateBloc, ReportCreateState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return Container(
          width: size.width * 0.4,
          child: ElevatedButton(
            key: const Key('reportForm_edit_raisedButton'),
            child: const Text(
              'Save',
              style: TextStyle(
                color: Colors.white,
                letterSpacing: 1.5,
              ),
            ),
            onPressed: () {},
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
