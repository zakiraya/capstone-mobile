import 'dart:io';

import 'package:capstone_mobile/src/blocs/violation_create/violation_bloc.dart';
import 'package:capstone_mobile/src/blocs/violation_list/violation_list_bloc.dart';
import 'package:capstone_mobile/src/data/models/branch/branch.dart';
import 'package:capstone_mobile/src/data/models/regulation/regulation.dart';
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
    this.isEditing = false,
    this.violation,
    this.position,
  }) : super(key: key);

  final ViolationListBloc bloc;
  final Size size;
  final bool isEditing;
  final Violation violation;
  final int position;

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
  void initState() {
    super.initState();
    _image = widget.violation != null ? File(widget.violation.imagePath) : null;
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
                        child: Text(widget.isEditing
                            ? 'Violation Edit'
                            : 'Violation Create'),
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
                                    var state = bloc.state;
                                    Navigator.pop<List>(
                                      context,
                                      [
                                        Violation(
                                          name: state.name,
                                          description:
                                              state.violationDescription.value,
                                          regulationId: state
                                              .violationRegulation.value.id,
                                          regulationName: state
                                              .violationRegulation.value.name,
                                          imagePath: _image.path,
                                          branchId:
                                              state.violationBranch.value.id,
                                          branchName:
                                              state.violationBranch.value.name,
                                        ),
                                        widget.position,
                                      ],
                                    );
                                  }
                                : null,
                            child: Text(
                                '${widget.isEditing == true ? 'Save' : 'Add'}'),
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
                  child: RegulationDropdown(
                    initValue: widget.isEditing == true
                        ? Regulation(
                            id: widget.violation.regulationId,
                            name: widget.violation.regulationName,
                          )
                        : null,
                  ),
                ),
                Container(
                  child: Text('Branch:'),
                ),
                Container(
                  child: BranchDropdown(
                    initValue: widget.isEditing == true
                        ? Branch(
                            id: widget.violation.branchId,
                            name: widget.violation.branchName,
                          )
                        : null,
                  ),
                ),
                Container(
                  child: _ViolationDescriptionInput(
                    initValue: widget.isEditing == true
                        ? widget.violation.description
                        : null,
                  ),
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
  final String initValue;

  const _ViolationDescriptionInput({Key key, this.initValue}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ViolationCreateBloc, ViolationCreateState>(
        buildWhen: (previous, current) =>
            previous.violationDescription != current.violationDescription,
        builder: (contex, state) {
          return TextFormField(
            initialValue: initValue ?? '',
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
