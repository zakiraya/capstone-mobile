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
        if (state is ViolationLoadFailure) {
          CoolAlert.show(
            context: context,
            type: CoolAlertType.error,
            title: "Oops...",
            text: "Sorry, something went wrong",
          );
        }
      },
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
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
                      'Violation of ${widget.violation.name}',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 24.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              Divider(
                color: Theme.of(context).primaryColor,
              ),
              // regulation dropdown
              Container(
                child: Text(
                  'Regulation:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
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
                child: Text('Branch:',
                    style: TextStyle(fontWeight: FontWeight.bold)),
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
              SizedBox(
                height: 16,
              ),
              Container(
                child: _ViolationDescriptionInput(
                  initValue: widget.isEditing == true
                      ? widget.violation.description
                      : null,
                ),
              ),

              SizedBox(
                height: 16,
              ),
              Container(
                child: Text('Evidence:',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              SizedBox(
                height: 16,
              ),
              _image != null
                  ? Stack(children: [
                      Image(
                        image: isNetworkImage == true
                            ? NetworkImage(_image.path)
                            : FileImage(_image),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _image = null;
                            });
                          },
                          child: Container(
                            height: 24,
                            width: 24,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.red),
                            ),
                            child: Icon(
                              Icons.clear,
                              color: Colors.red,
                              size: 16.0,
                            ),
                          ),
                        ),
                      ),
                    ])
                  : Container(),
              _image == null
                  ? GestureDetector(
                      onTap: () {
                        getImage();
                      },
                      child: Card(
                        elevation: 5,
                        color: Color(0xffF2F2F2),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.2,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.add),
                              Text('Add evidence'),
                            ],
                          ),
                        ),
                      ),
                    )
                  : Container(),
              Container(
                child: BlocBuilder<ViolationCreateBloc, ViolationCreateState>(
                  buildWhen: (previous, current) =>
                      previous.status != current.status,
                  builder: (context, state) {
                    var bloc = BlocProvider.of<ViolationCreateBloc>(context);

                    return Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.3),
                      child: ElevatedButton(
                        onPressed: state.status.isValid && _image != null
                            ? () {
                                widget.onSaveCallBack(
                                  widget.violation.copyWith(
                                    name: widget.violation.name,
                                    description:
                                        bloc.state.violationDescription.value,
                                    regulationId:
                                        bloc.state.violationRegulation.value.id,
                                    regulationName: bloc
                                        .state.violationRegulation.value.name,
                                    imagePath: _image.path,
                                    branchId:
                                        bloc.state.violationBranch.value.id,
                                    branchName:
                                        bloc.state.violationBranch.value.name,
                                  ),
                                );
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
                        child: Text(
                            '${widget.isEditing == true ? 'Save' : 'Add'}'),
                        style: ElevatedButton.styleFrom(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ViolationDescriptionInput extends StatefulWidget {
  final String initValue;

  const _ViolationDescriptionInput({Key key, this.initValue}) : super(key: key);

  @override
  __ViolationDescriptionInputState createState() =>
      __ViolationDescriptionInputState();
}

class __ViolationDescriptionInputState
    extends State<_ViolationDescriptionInput> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.initValue != null || widget.initValue != '') {
      context.read<ViolationCreateBloc>().add(
            ViolationDescriptionChanged(
              violationDescription: widget.initValue,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ViolationCreateBloc, ViolationCreateState>(
        buildWhen: (previous, current) =>
            previous.violationDescription != current.violationDescription,
        builder: (contex, state) {
          return TextFormField(
            initialValue: widget.initValue ?? '',
            key: const Key('violationForm_violationDescriptionInput_textField'),
            onChanged: (violationDescription) {
              context.read<ViolationCreateBloc>().add(
                    ViolationDescriptionChanged(
                      violationDescription: violationDescription,
                    ),
                  );
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[200],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              labelText: 'Description:',
              labelStyle: TextStyle(fontWeight: FontWeight.bold),
              errorText: state.violationDescription.invalid
                  ? 'invalid violation description'
                  : null,
            ),
            maxLines: 5,
          );
        });
  }
}
