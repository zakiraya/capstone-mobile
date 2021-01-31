import 'package:capstone_mobile/src/blocs/report_create/report_create_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class ReportForm extends StatefulWidget {
  @override
  _ReportFormState createState() => _ReportFormState();
}

class _ReportFormState extends State<ReportForm> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Padding(
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  // child: Text("Created by: Lai Van Some"),
                  ),
              Container(
                  // child: Text("Status: "),
                  ),
            ],
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
                _ReportNameInput(),
                SizedBox(
                  height: 15,
                ),
                Container(
                  child: Text("Created on: "),
                ),
                Container(
                  child: Text('Abc'),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  child: Text("Submitted on: "),
                ),
                Container(
                  child: Text('Abc'),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
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
          Card(
            elevation: 4,
            shadowColor: Colors.purple[300],
            child: InkWell(
              splashColor: Colors.blue.withAlpha(30),
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('assets/avt.jpg'),
                          ),
                        ),
                      ),
                    ),
                    // SizedBox(
                    //   width: 16,
                    // ),
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("#error code"),
                            SizedBox(
                              height: 8,
                            ),
                            Text("Violation name"),
                            SizedBox(
                              height: 12,
                            ),
                            Text(
                              "Violator: Hoang Gia Bao",
                              style: TextStyle(fontSize: 12),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Violated date: 28/12/1998",
                                  style: TextStyle(fontSize: 8),
                                ),
                                Text("Status: Rejected",
                                    style: TextStyle(fontSize: 8)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Icon(
                      Icons.edit_outlined,
                      size: 16.0,
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(),
              Container(
                child: IconButton(
                  onPressed: () {
                    showMaterialModalBottomSheet(
                        expand: false,
                        context: context,
                        backgroundColor: Colors.transparent,
                        builder: (context) => ViolationCreateModal());
                  },
                  icon: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  color: Colors.blue[900],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 32,
          ),
          _CreateButton(),
        ],
      ),
    );
  }
}

class ViolationCreateModal extends StatelessWidget {
  const ViolationCreateModal({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      clipBehavior: Clip.antiAlias,
      borderRadius: BorderRadius.circular(16.0),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                // mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(child: Text('fawefafe')),
                  Container(
                    child: IconButton(
                      icon: Icon(Icons.close_rounded),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
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
            key: const Key('reportForm_reportDescriptionInput_textField'),
            onChanged: (reportDescription) =>
                context.read<ReportCreateBloc>().add(
                      ReportDescriptionChanged(
                          reportDescription: reportDescription),
                    ),
            decoration: InputDecoration(
              labelText: 'Report Description',
              errorText: state.reportName.invalid
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
                      key: const Key('reportForm_saveDraft_raisedButton'),
                      child: const Text(
                        'Save Draft',
                        style: TextStyle(
                          color: Colors.white,
                          letterSpacing: 1.5,
                        ),
                      ),
                      onPressed: state.status.isValidated
                          ? () {
                              context
                                  .read<ReportCreateBloc>()
                                  .add(ReportCreateSubmitted(isDraft: true));
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
                      key: const Key('reportForm_submit_raisedButton'),
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
