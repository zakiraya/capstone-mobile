import 'dart:io';

import 'package:capstone_mobile/src/blocs/violation_list/violation_list_bloc.dart';
import 'package:capstone_mobile/src/blocs/violation_list_create/violation_create_bloc.dart';
import 'package:capstone_mobile/src/ui/widgets/violation/dropdown_field.dart';
import 'package:capstone_mobile/src/data/models/regulation/regulation.dart';
import 'package:capstone_mobile/src/data/models/violation/violation.dart';
import 'package:capstone_mobile/src/ui/utils/dropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:formz/formz.dart';
import 'package:capstone_mobile/generated/l10n.dart';

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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // action button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Text(
                          widget.isEditing
                              ? S.of(context).EDIT_VIOLATION
                              : S.of(context).NEW_VIOLATION,
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 24.0,
                          )),
                    ),
                    IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    )
                  ],
                ),
                Divider(
                  color: Theme.of(context).primaryColor,
                ),
                // regulation dropdown
                Container(
                  child: Text(
                    S.of(context).REGULATION,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                DropdownFieldRegulation(),
                // Container(
                //   child: RegulationDropdown(
                //     initValue: widget.isEditing == true
                //         ? Regulation(
                //             id: widget.violation.regulationId,
                //             name: widget.violation.regulationName,
                //           )
                //         : null,
                //   ),
                // ),
                SizedBox(
                  height: 16,
                ),
                Container(
                  child: Text(
                    S.of(context).BRANCH,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
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
                  child: Text(
                    S.of(context).DESCRIPTION,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
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
                  height: 16,
                ),
                Container(
                  child: Text(S.of(context).EVIDENCE,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                _image == null
                    ? GestureDetector(
                        onTap: getImage,
                        child: Card(
                          color: Colors.grey,
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.15,
                            width: MediaQuery.of(context).size.width * 0.22,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                                Text(
                                  S.of(context).ADD_IMAGE,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : Container(),
                _image != null
                    ? Stack(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.15,
                            width: MediaQuery.of(context).size.width * 0.22,
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
                        ],
                      )
                    : Container(),
                Center(
                  child: Builder(builder: (context) {
                    return BlocBuilder<ViolationCreateBloc,
                        ViolationCreateState>(
                      buildWhen: (previous, current) =>
                          previous.status != current.status,
                      builder: (context, state) {
                        var bloc =
                            BlocProvider.of<ViolationCreateBloc>(context);
                        return ElevatedButton(
                          onPressed: bloc.state.status.isValid && _image != null
                              ? () async {
                                  var state = bloc.state;
                                  Navigator.pop<List>(
                                    context,
                                    [
                                      Violation(
                                        name: state.name,
                                        description:
                                            state.violationDescription.value,
                                        regulationId:
                                            state.violationRegulation.value.id,
                                        regulationName: state
                                            .violationRegulation.value.name,
                                        imagePath: _image.path,
                                        // branchId:
                                        //     state.violationBranch.value.id,
                                        // branchName:
                                        //     state.violationBranch.value.name,
                                      ),
                                      widget.position,
                                    ],
                                  );
                                }
                              : null,
                          child: Text(
                              '${widget.isEditing == true ? S.of(context).VIOLATION_CREATE_MODAL_ADD : S.of(context).VIOLATION_CREATE_MODAL_ADD}'),
                          style: ElevatedButton.styleFrom(
                            elevation: 5.0,
                            primary: Theme.of(context).primaryColor,
                            padding: EdgeInsets.symmetric(horizontal: 24),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        );
                      },
                    );
                  }),
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
              fillColor: Colors.grey[200],
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              errorText: state.violationDescription.invalid
                  ? 'invalid violation description'
                  : null,
            ),
            maxLines: 5,
          );
        });
  }
}
