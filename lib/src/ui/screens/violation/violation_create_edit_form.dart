import 'dart:io';
import 'package:capstone_mobile/src/blocs/violation/violation_bloc.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:formz/formz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'package:capstone_mobile/src/data/models/violation/violation.dart';
import 'package:capstone_mobile/src/blocs/violation_create/violation_bloc.dart';
import 'package:capstone_mobile/src/data/models/branch/branch.dart';
import 'package:capstone_mobile/src/data/models/regulation/regulation.dart';
import 'package:capstone_mobile/src/ui/utils/dropdown.dart';

class ViolationCreateEditForm extends StatefulWidget {
  const ViolationCreateEditForm({
    Key key,
    @required this.violation,
    @required this.size,
    @required this.isEditing,
    @required this.onSaveCallBack,
  }) : super(key: key);

  final Violation violation;
  final Size size;
  final bool isEditing;
  final Function onSaveCallBack;

  @override
  _ViolationCreateEditFormState createState() =>
      _ViolationCreateEditFormState();
}

class _ViolationCreateEditFormState extends State<ViolationCreateEditForm> {
  File _image;
  bool isNetworkImage;

  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        isNetworkImage = false;
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  void initState() {
    super.initState();
    // _image = widget.violation != null ? File(widget.violation.imagePath) : null;
    if (widget.violation != null) {
      _image = File(widget.violation.imagePath);
      isNetworkImage = widget.violation.imagePath.contains('http');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ViolationBloc, ViolationState>(
      listener: (context, state) {
        if (state is ViolationLoadSuccess) {
          Navigator.of(context)
              .popUntil(ModalRoute.withName(state.screen ?? '/Home'));
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // action button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Text(
                      widget.isEditing ? 'Violation Edit' : 'Violation Create'),
                ),
                BlocBuilder<ViolationCreateBloc, ViolationCreateState>(
                  buildWhen: (previous, current) =>
                      previous.status != current.status,
                  builder: (context, state) {
                    var bloc = BlocProvider.of<ViolationCreateBloc>(context);

                    return ElevatedButton(
                      onPressed: bloc.state.status.isValid
                          ? () {
                              widget.onSaveCallBack(
                                widget.violation.copyWith(
                                  name: widget.violation.name,
                                  description: state.violationDescription.value,
                                  regulationId:
                                      state.violationRegulation.value.id,
                                  regulationName:
                                      state.violationRegulation.value.name,
                                  imagePath: _image.path,
                                  branchId: state.violationBranch.value.id,
                                  branchName: state.violationBranch.value.name,
                                ),
                              );
                              // Navigator.pop(context);
                              showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (context) {
                                    return SimpleDialog(
                                      title: const Text('Submitting...'),
                                      children: [
                                        Center(
                                          child: CircularProgressIndicator(),
                                        )
                                      ],
                                    );
                                  });
                            }
                          : null,
                      child:
                          Text('${widget.isEditing == true ? 'Save' : 'Add'}'),
                      style: ElevatedButton.styleFrom(),
                    );
                  },
                ),
              ],
            ),
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
            Center(
              child: Container(
                // width: size.width * 0.7,
                height: widget.size.height * 0.3,

                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(2),
                  image: DecorationImage(
                    fit: BoxFit.contain,
                    image: _image == null
                        ? AssetImage('assets/avt.jpg')
                        : isNetworkImage == true
                            ? NetworkImage(_image.path)
                            : FileImage(_image),
                  ),
                ),
              ),
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
                        violationDescription: violationDescription,
                      ),
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
