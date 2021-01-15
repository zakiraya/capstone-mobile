import 'package:capstone_mobile/src/ui/utils/custom_text_field.dart';
import 'package:flutter/material.dart';

class ChangePasswordScreen extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => ChangePasswordScreen());
  }

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Edit Password'),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          padding: EdgeInsets.only(left: 16, top: 25, right: 16),
          child: Center(
            child: ListView(
              children: [
                // Text(
                //   'Edit Password',
                //   style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
                // ),
                SizedBox(
                  height: 15,
                ),
                Center(
                  child: Stack(
                    children: [
                      Container(
                        width: 130,
                        height: 130,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 4,
                            color: Theme.of(context).scaffoldBackgroundColor,
                          ),
                          boxShadow: [
                            BoxShadow(
                              spreadRadius: 2,
                              blurRadius: 10,
                              color: Colors.black.withOpacity(0.1),
                              offset: Offset(0, 10),
                            ),
                          ],
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('assets/avt.jpg'),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.blue,
                          ),
                          child: Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 35,
                ),
                CustomTextField(
                  label: "Password",
                  placeholder: '********',
                  isHidden: true,
                ),
                CustomTextField(
                    label: "Confirm password",
                    placeholder: '*******',
                    isHidden: true),
                SizedBox(
                  height: 35,
                ),
                Row(
                  children: [
                    OutlineButton(
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      onPressed: () {},
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          fontSize: 14,
                          letterSpacing: 2.2,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    RaisedButton(
                      color: Colors.blue,
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      onPressed: () {},
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Text(
                        'Save',
                        style: TextStyle(
                            fontSize: 14,
                            letterSpacing: 2.2,
                            color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
