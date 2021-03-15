import 'dart:io';
import 'package:capstone_mobile/generated/l10n.dart';
import 'package:capstone_mobile/src/blocs/violation_list_create/violation_create_bloc.dart';
import 'package:capstone_mobile/src/ui/constants/constant.dart';
import 'package:capstone_mobile/src/ui/widgets/violation/dropdown_field.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:formz/formz.dart';

import 'package:capstone_mobile/src/data/models/violation/violation.dart';
import 'package:capstone_mobile/src/data/models/regulation/regulation.dart';

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
    var theme = Theme.of(context);
    return BlocListener<ViolationCreateBloc, ViolationCreateState>(
      listener: (context, state) {
        if (state.status.isSubmissionSuccess) {
          // Navigator.pop(context);
          CoolAlert.show(
            context: context,
            type: CoolAlertType.success,
            text: S.of(context).POPUP_CREATE_VIOLATION_SUCCESS,
          ).then((value) {
            Navigator.of(context)
                .popUntil(ModalRoute.withName('/ViolationDetailScreen'));
          });
        }
        if (state.status.isSubmissionInProgress) {
          CoolAlert.show(
            barrierDismissible: false,
            context: context,
            type: CoolAlertType.loading,
            text: S.of(context).POPUP_CREATE_VIOLATION_SUBMITTING,
          );
        }
        if (state.status.isSubmissionFailure) {
          CoolAlert.show(
            context: context,
            type: CoolAlertType.error,
            title: "Oops...",
            text: S.of(context).POPUP_CREATE_VIOLATION_FAIL,
          ).then((value) => Navigator.pop(context));
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
          padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
          child: ListView(
            children: [
              // action button
              Container(
                child: Text(
                  S.of(context).VIOLATION +
                      ' ' +
                      S.of(context).OF +
                      ' ' +
                      '${widget.violation.regulationName}',
                  overflow: TextOverflow.visible,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: theme.textTheme.headline5.fontSize,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    child: Text(S.of(context).VIOLATION_STATUS + ': '),
                  ),
                  Container(
                    child: Text(
                      "${widget.violation?.status}",
                      style: TextStyle(
                          color: Constant
                              .violationStatusColors[widget.violation?.status]),
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
                  '- ' + S.of(context).REGULATION + ':',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              DropdownFieldRegulation(
                  initValue: widget.isEditing == true
                      ? Regulation(
                          id: widget.violation.regulationId,
                          name: widget.violation.regulationName,
                        )
                      : null),
              SizedBox(
                height: 16,
              ),
              Container(
                child: Text(
                  '- ' + S.of(context).DESCRIPTION + ':',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 8,
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
                child: Text('- ' + S.of(context).EVIDENCE + ':',
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
              SizedBox(
                height: 24.0,
              ),
              _ActionButton(image: _image, widget: widget, theme: theme),
              SizedBox(
                height: 24,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    Key key,
    @required File image,
    @required this.widget,
    @required this.theme,
  })  : _image = image,
        super(key: key);

  final File _image;
  final widget;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocBuilder<ViolationCreateBloc, ViolationCreateState>(
        buildWhen: (previous, current) => previous.status != current.status,
        builder: (context, state) {
          var bloc = BlocProvider.of<ViolationCreateBloc>(context);

          return Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.3),
            child: ElevatedButton(
              onPressed: state.status.isValid && _image != null
                  ? () {
                      bloc.add(
                        ViolationUpdated(
                          violation: widget.violation.copyWith(
                            name: widget.violation.name,
                            description: bloc.state.violationDescription.value,
                            regulationId:
                                bloc.state.violationRegulation.value.id,
                            regulationName:
                                bloc.state.violationRegulation.value.name,
                            imagePath: _image.path,
                          ),
                        ),
                      );
                      // widget.onSaveCallBack(

                      // );
                    }
                  : null,
              child: Text(
                  '${widget.isEditing == true ? S.of(context).SAVE : 'Add'}'),
              style: ElevatedButton.styleFrom(
                primary: theme.primaryColor,
                elevation: 5,
              ),
            ),
          );
        },
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
            style: TextStyle(fontSize: 14),
            decoration: InputDecoration(
              fillColor: Colors.grey[200],
              filled: true,
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              errorText: state.violationDescription.invalid
                  ? 'invalid violation description'
                  : null,
            ),
            // minLines: 5,
            minLines: 5,
            maxLines: 10,
          );
        });
  }
}
