import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    Key key,
    @required this.label,
    this.placeholder,
    @required this.isHidden,
  }) : super(key: key);

  final String label;
  final String placeholder;
  final bool isHidden;

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool showPassword = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: widget.isHidden ? showPassword : false,
      decoration: InputDecoration(
        suffixIcon: widget.isHidden
            ? IconButton(
                icon: Icon(Icons.remove_red_eye),
                color: Colors.grey,
                onPressed: () {
                  setState(() {
                    showPassword = !showPassword;
                  });
                },
              )
            : null,
        labelText: widget.label,
        // contentPadding: EdgeInsets.only(bottom: 3),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintText: widget.placeholder ?? '',
        hintStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w200,
          color: Colors.black,
        ),
      ),
    );
  }
}
