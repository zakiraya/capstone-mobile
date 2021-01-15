import 'package:capstone_mobile/src/blocs/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => SettingsScreen());
  }

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16, top: 25, right: 16),
      child: ListView(
        children: [
          SizedBox(
            height: 35,
          ),
          Row(
            children: [
              Icon(
                Icons.person,
                color: Theme.of(context).primaryColor,
              ),
              SizedBox(
                width: 15,
              ),
              Text(
                'Account',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
          Divider(
            height: 15,
            thickness: 2,
          ),
          SizedBox(
            height: 15,
          ),
          GestureDetector(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Change password'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Option 1'),
                          Text('Option 2'),
                          Text('Option 3'),
                        ],
                      ),
                      actions: [
                        FlatButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Close'),
                        )
                      ],
                    );
                  });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Change Password',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey,
                )
              ],
            ),
          ),
          SizedBox(
            height: 35,
          ),
          Row(
            children: [
              Icon(
                Icons.person,
                color: Theme.of(context).primaryColor,
              ),
              SizedBox(
                width: 15,
              ),
              Text(
                'Notifications',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
          Divider(
            height: 15,
            thickness: 2,
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'New for you',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
              Switch(
                activeColor: Theme.of(context).primaryColor,
                value: true,
                onChanged: (bool val) {},
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  onPrimary: Colors.red,
                  primary: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  'SIGN OUT',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  context
                      .read<AuthenticationBloc>()
                      .add(AuthenticationLogoutRequested());
                }),
          ),
        ],
      ),
    );
  }
}
