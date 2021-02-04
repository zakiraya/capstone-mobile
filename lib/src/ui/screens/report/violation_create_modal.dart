import 'dart:io';

import 'package:capstone_mobile/src/blocs/report_create/report_create_bloc.dart';
import 'package:capstone_mobile/src/blocs/violation/violation_bloc.dart';
import 'package:capstone_mobile/src/blocs/violation_create/violation_bloc.dart';
import 'package:capstone_mobile/src/data/models/violation/violation.dart';
import 'package:capstone_mobile/src/ui/utils/dropdown.dart';
import 'package:capstone_mobile/src/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:formz/formz.dart';

class ViolationCreateModal extends StatefulWidget {
  const ViolationCreateModal({Key key, this.context}) : super(key: key);

  final BuildContext context;

  @override
  _ViolationCreateModalState createState() => _ViolationCreateModalState();
}

class _ViolationCreateModalState extends State<ViolationCreateModal> {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<ReportCreateBloc>(widget.context);
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);
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
                    child: Text('Cancel'),
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
  }
}

class ModalBody extends StatefulWidget {
  const ModalBody({
    Key key,
    @required this.bloc,
    @required this.size,
  }) : super(key: key);

  final ReportCreateBloc bloc;
  final Size size;

  @override
  _ModalBodyState createState() => _ModalBodyState();
}

class _ModalBodyState extends State<ModalBody> {
  File _image;

  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      clipBehavior: Clip.antiAlias,
      // borderRadius: BorderRadius.circular(16.0),
      child: SafeArea(
        top: false,
        child: BlocProvider(
          create: (context) => ViolationCreateBloc(),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // action button
                Builder(builder: (context) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text('Violation create'),
                      ),
                      BlocBuilder<ViolationCreateBloc, ViolationCreateState>(
                        buildWhen: (previous, current) =>
                            previous.status != current.status,
                        builder: (context, state) {
                          var bloc =
                              BlocProvider.of<ViolationCreateBloc>(context);
                          return ElevatedButton(
                            onPressed: bloc.state.status.isValid
                                ? () async {
                                    // bloc.add(ViolationAdded());
                                    var state = bloc.state;

                                    // if (state.status.isSubmissionInProgress) {
                                    // widget.bloc.add(
                                    //   ReportViolationsChanged(
                                    //     reportViolation: Violation(
                                    //       violationCode: "fawefw",
                                    //       createdDate:
                                    //           Utils.formatDate(DateTime.now()),
                                    //       violationName: state.name,
                                    //       description:
                                    //           state.violationDescription.value,
                                    //       regulationId:
                                    //           state.violationRegulation.value,
                                    //     ),
                                    //   ),
                                    // );
                                    // }
                                    Navigator.pop<Violation>(
                                      context,
                                      Violation(
                                        violationCode: "fawefw",
                                        createdDate:
                                            Utils.formatDate(DateTime.now()),
                                        violationName: state.name,
                                        description:
                                            state.violationDescription.value,
                                        regulationId:
                                            state.violationRegulation.value,
                                      ),
                                    );
                                  }
                                : null,
                            child: Text('Add'),
                            style: ElevatedButton.styleFrom(),
                          );
                        },
                      ),
                    ],
                  );
                }),
                Divider(
                  color: Colors.red,
                ),
                // regulation dropdown
                Container(
                  child: Text('Violation type:'),
                ),
                Container(
                  child: RegulationDropdown(),
                ),
                Container(
                  child: _ViolationDescriptionInput(),
                ),
                SizedBox(
                  height: 8,
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: widget.size.width * 0.7,
                      height: widget.size.height * 0.3,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: _image == null
                              ? AssetImage('assets/avt.jpg')
                              : FileImage(_image),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  child: TextButton(
                    onPressed: getImage,
                    child: Text('Add evidence'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ViolationDescriptionInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ViolationCreateBloc, ViolationCreateState>(
        buildWhen: (previous, current) =>
            previous.violationDescription != current.violationDescription,
        builder: (contex, state) {
          return TextField(
            key: const Key('violationForm_violationDescriptionInput_textField'),
            onChanged: (violationDescription) =>
                context.read<ViolationCreateBloc>().add(
                      ViolationDescriptionChanged(
                          violationDescription: violationDescription),
                    ),
            decoration: InputDecoration(
              labelText: 'Violation Description:',
              errorText: state.violationDescription.invalid
                  ? 'invalid violation description'
                  : null,
            ),
          );
        });
  }
}

// class _AddButton extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<ViolationCreateBloc, ViolationCreateState>(
//       buildWhen: (previous, current) => previous.status != current.status,
//       builder: (context, state) {
//         return ElevatedButton(
//                         onPressed:
//                         state.status.isValid

//                         ? () {
//                           // widget.bloc.add(
//                           //   ReportViolationsChanged(
//                           //     reportViolation:
//                           //         Violation(id: 1, violationCode: "fawefw"),
//                           //   ),
//                           // );
//                           context
//                               .read<ViolationCreateBloc>()
//                               .add(const ViolationAdded());
//                               var bloc = BlocProvider.of<ViolationCreateBloc>(context);

//                         }
//                         : null,
//                         child: Text('Add'),
//                       );
//       },
//     );
//   }
// }
