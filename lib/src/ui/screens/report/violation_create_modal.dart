import 'dart:io';

import 'package:capstone_mobile/src/blocs/violation_create/violation_bloc.dart';
import 'package:capstone_mobile/src/blocs/violation_list/violation_list_bloc.dart';
import 'package:capstone_mobile/src/data/models/violation/violation.dart';
import 'package:capstone_mobile/src/ui/utils/dropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:formz/formz.dart';

class ModalBody extends StatefulWidget {
  const ModalBody({
    Key key,
    @required this.bloc,
    @required this.size,
  }) : super(key: key);

  final ViolationListBloc bloc;
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
                            onPressed: bloc.state.status.isValid &&
                                    _image != null
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
                                        name: state.name,
                                        description:
                                            state.violationDescription.value,
                                        regulationId:
                                            state.violationRegulation.value,
                                        imagePath: _image.path,
                                        branchId: state.violationBranch.value,
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
                  child: Text('Branch:'),
                ),
                Container(
                  child: BranchDropdown(),
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
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              labelText: 'Description:',
              errorText: state.violationDescription.invalid
                  ? 'invalid violation description'
                  : null,
            ),
            maxLines: 5,
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
