import 'package:capstone_mobile/src/blocs/report_create/report_create_bloc.dart';
import 'package:capstone_mobile/src/data/models/branch/branch.dart';
import 'package:capstone_mobile/src/data/models/violation/violation.dart';
import 'package:capstone_mobile/src/data/repositories/branch/branch_repository.dart';
import 'package:capstone_mobile/src/ui/screens/report/violation_card.dart';
import 'package:capstone_mobile/src/ui/screens/report/violation_create_modal.dart';
import 'package:capstone_mobile/src/ui/utils/dropdown.dart';
import 'package:capstone_mobile/src/utils/utils.dart';
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
              errorText: state.reportDescription.invalid
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
                        // showMaterialModalBottomSheet(
                        //   expand: false,
                        //   context: context,
                        //   backgroundColor: Colors.transparent,
                        //   builder: (context) => ViolationCreateModal(
                        //     context: context,
                        //   ),
                        // );
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
      violationName: vio.regulationId.toString(),
    );
    violationCards.add(card);
  }
  return violationCards;
}

void _showModalOne(BuildContext context) {
  final bloc = BlocProvider.of<ReportCreateBloc>(context);
  var size = MediaQuery.of(context).size;
  Future<Violation> future = showModalBottomSheet(
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    context: context,
    builder: (BuildContext context) {
      return ModalBody(bloc: bloc, size: size);
    },
  );
  future.then((value) {
    bloc.add(
      ReportViolationsChanged(
        reportViolation: Violation(
          violationCode: "fawefw",
          createdDate: Utils.formatDate(DateTime.now()),
          violationName: value.violationName,
          description: value.description,
          regulationId: value.regulationId,
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
