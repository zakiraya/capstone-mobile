import 'package:capstone_mobile/src/blocs/report_create/report_create_bloc.dart';
import 'package:capstone_mobile/src/ui/screens/report/report_violation_list.dart';
import 'package:capstone_mobile/src/ui/utils/dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class ReportForm extends StatefulWidget {
  @override
  _ReportFormState createState() => _ReportFormState();
}

class _ReportFormState extends State<ReportForm> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return BlocListener<ReportCreateBloc, ReportCreateState>(
        listener: (context, state) {
          if (state.status.isSubmissionInProgress) {
            return SimpleDialog(
              title: const Text('Submitting...'),
              children: [
                Center(
                  child: CircularProgressIndicator(),
                )
              ],
            );
          }
          if (state.status.isSubmissionSuccess) {
            Navigator.pop(context);
          }
        },
        child: Padding(
          padding: EdgeInsets.only(left: 16, top: 8, right: 16),
          child: ListView(
            children: [
              Container(
                child: Text(
                  'New report',
                  style: TextStyle(
                      color: theme.primaryColor,
                      fontSize: theme.textTheme.headline4.fontSize),
                ),
              ),
              Divider(
                color: Colors.black,
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // _ReportNameInput(),
                    Container(
                      child: Text(
                        "Branch: ",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    BranchDropdown(),
                    SizedBox(
                      height: 15,
                    ),
                    _ReportDescriptionInput(),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                child: Text("Violation list: "),
              ),
              SizedBox(
                height: 16,
              ),
              ReportListViewViolation(),
              SizedBox(
                height: 32,
              ),
              _CreateButton(),
            ],
          ),
        ));
  }
}

class _ReportNameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReportCreateBloc, ReportCreateState>(
        buildWhen: (previous, current) =>
            previous.reportName != current.reportName,
        builder: (contex, state) {
          return TextField(
            key: const Key('reportForm_reportNameInput_textField'),
            onChanged: (reportName) => context
                .read<ReportCreateBloc>()
                .add(ReportNameChanged(reportName: reportName)),
            decoration: InputDecoration(
              labelText: 'Report name',
              errorText:
                  state.reportName.invalid ? 'invalid report name' : null,
            ),
          );
        });
  }
}

class _ReportDescriptionInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReportCreateBloc, ReportCreateState>(
        buildWhen: (previous, current) =>
            previous.reportDescription != current.reportDescription,
        builder: (contex, state) {
          return TextField(
            key: const Key('createForm_reportDescriptionInput_textField'),
            onChanged: (reportDescription) =>
                context.read<ReportCreateBloc>().add(
                      ReportDescriptionChanged(
                          reportDescription: reportDescription),
                    ),
            decoration: InputDecoration(
              labelText: 'Report Description:',
              errorText: state.reportDescription.invalid
                  ? 'invalid report description'
                  : null,
            ),
          );
        });
  }
}

class _CreateButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return BlocBuilder<ReportCreateBloc, ReportCreateState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? CircularProgressIndicator()
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: size.width * 0.4,
                    child: ElevatedButton(
                      key: const Key('createForm_saveDraft_raisedButton'),
                      child: const Text(
                        'Save Draft',
                        style: TextStyle(
                          color: Colors.white,
                          letterSpacing: 1.5,
                        ),
                      ),
                      onPressed: state.reportBranch.value > 0
                          ? () {
                              context
                                  .read<ReportCreateBloc>()
                                  .add(ReportCreateSubmitted());
                              // Navigator.pop(context);
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        onPrimary: Colors.red,
                        primary: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: size.width * 0.4,
                    child: ElevatedButton(
                      key: const Key('createForm_submit_raisedButton'),
                      child: const Text(
                        'Submit',
                        style: TextStyle(
                          color: Colors.white,
                          letterSpacing: 1.5,
                        ),
                      ),
                      onPressed: state.status.isValidated
                          ? () {
                              context
                                  .read<ReportCreateBloc>()
                                  .add(ReportCreateSubmitted(isDraft: false));

                              Navigator.pop(context);
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        onPrimary: Colors.red,
                        primary: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                ],
              );
      },
    );
  }
}
