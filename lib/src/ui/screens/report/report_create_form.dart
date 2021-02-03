import 'package:capstone_mobile/src/blocs/report_create/report_create_bloc.dart';
import 'package:capstone_mobile/src/data/models/branch/branch.dart';
import 'package:capstone_mobile/src/data/models/violation/violation.dart';
import 'package:capstone_mobile/src/data/repositories/branch/branch_repository.dart';
import 'package:capstone_mobile/src/ui/screens/report/violation_card.dart';
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
                _BranchDropdown(),
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
          _ReportListViolationList(),
          SizedBox(
            height: 32,
          ),
          _CreateButton(),
        ],
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

class _BranchDropdown extends StatefulWidget {
  _BranchDropdown({Key key}) : super(key: key);

  @override
  __BranchDropdownState createState() => __BranchDropdownState();
}

class __BranchDropdownState extends State<_BranchDropdown> {
  BranchRepository _branchRepository = BranchRepository();
  List<Branch> _branches = List();
  Branch dropdownValue;

  Future<String> getBranches() async {
    // var branches = await _branchRepository.fetchBranches(
    //     "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InFjIiwicm9sZUlkIjoiNiIsInJvbGVOYW1lIjoiUUMgTWFuYWdlciIsImp0aSI6IjAyNDNjMTQxLWYwMWEtNDY3Ny05NWM0LTE2NjE5Y2EzNzA4ZSIsIm5iZiI6MTYxMjA2ODMyNCwiZXhwIjoxNjEyMDY4NjI0LCJpYXQiOjE2MTIwNjgzMjQsImF1ZCI6Ik1hdmNhIn0.dK4_IdMsgrfvzc_8TnN5hPOXhFdfqOOh08gSFcb5WiI");

    setState(() => _branches = [
          Branch(id: 1, name: "Br01"),
          Branch(id: 2, name: "Br02"),
          Branch(id: 3, name: "Br03"),
          Branch(id: 4, name: "Br04"),
        ]);

    return 'success';
  }

  @override
  void initState() {
    super.initState();
    this.getBranches();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      child: DropdownButton<Branch>(
        isExpanded: true,
        value: dropdownValue,
        icon: Icon(Icons.arrow_drop_down),
        iconSize: 24,
        elevation: 16,
        style: TextStyle(color: Colors.deepPurple),
        underline: Container(
          height: 1,
          color: Colors.black38,
        ),
        onChanged: (newValue) {
          setState(() {
            print('new value: ${newValue.name}');
            dropdownValue = newValue;
          });
          context.read<ReportCreateBloc>().add(
                ReportBranchChanged(reportBranchId: newValue.id),
              );
        },
        items: _branches.map<DropdownMenuItem<Branch>>((branch) {
          return DropdownMenuItem<Branch>(
            value: branch,
            child: Text(branch.name),
          );
        }).toList(),
      ),
    );
    // });
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
              labelText: 'Report Description:',
              errorText: state.reportName.invalid
                  ? 'invalid report description'
                  : null,
            ),
          );
        });
  }
}

class _ReportListViolationList extends StatelessWidget {
  final List<Violation> violationCards = List<Violation>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReportCreateBloc, ReportCreateState>(
        buildWhen: (previous, current) =>
            previous.reportListViolation != current.reportListViolation,
        builder: (contex, state) {
          return Column(
            children: [
              ...buildViolationList(state.reportListViolation.value ?? []),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(),
                  Container(
                    child: IconButton(
                      onPressed: () {
                        _showModalOne(context);
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
            ],
          );
        });
  }
}

List<Widget> buildViolationList(List<Violation> violations) {
  if (violations == null) return null;

  List<ViolationCard> violationCards = List<ViolationCard>();

  for (var vio in violations) {
    ViolationCard card = ViolationCard(
      errorCode: vio.violationCode,
      violationName: vio.violationName,
    );
    violationCards.add(card);
  }
  return violationCards;
}

void _showModalOne(BuildContext context) {
  final bloc = BlocProvider.of<ReportCreateBloc>(context);
  var size = MediaQuery.of(context).size;
  showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return Material(
          clipBehavior: Clip.antiAlias,
          // borderRadius: BorderRadius.circular(16.0),
          child: SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.grey,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Remove'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          print('asdfsd');
                          bloc.add(
                            ReportViolationsChanged(
                              reportViolation:
                                  Violation(id: 1, violationCode: "fawefw"),
                            ),
                          );
                        },
                        child: Text('Add'),
                      ),
                    ],
                  ),
                  Divider(
                    color: Colors.red,
                  ),
                  Container(
                    child: Text('Violator: violator\'s name'),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    child: Text('Date of violation: 28/12/1998'),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: size.width * 0.7,
                        height: size.height * 0.3,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('assets/avt.jpg'),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      });
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
                      onPressed: state.reportBranch.value > 0
                          ? () {
                              context
                                  .read<ReportCreateBloc>()
                                  .add(ReportCreateSubmitted());
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
