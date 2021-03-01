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
    var size = MediaQuery.of(context).size;
    final user = context.select((AuthenticationBloc bloc) => bloc.state.user);
    return Container(
      padding: EdgeInsets.only(left: 16, right: 16),
      child: ListView(
        children: [
          Row(
            children: [
              Container(
                width: 80,
                height: 80,
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
              SizedBox(
                width: 16.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Text(
                      '${user.fullName ?? 'name'}',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16.0),
                    ),
                  ),
                  Container(
                    child: Text('${user.email ?? 'mail'}'),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 24,
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              color: Colors.grey[200],
              height: size.height * 0.05,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Report list',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Colors.black,
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          GestureDetector(
            onTap: () {
              context
                  .read<AuthenticationBloc>()
                  .add(AuthenticationLogoutRequested());
            },
            child: Container(
              color: Colors.grey[200],
              height: size.height * 0.05,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Log out',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    Icon(
                      Icons.logout,
                      size: 16,
                      color: Colors.black,
                    )
                  ],
                ),
              ),
            ),
          ),

          // Row(
          //   children: [
          //     Icon(
          //       Icons.person,
          //       color: Theme.of(context).primaryColor,
          //     ),
          //     SizedBox(
          //       width: 15,
          //     ),
          //     Text(
          //       'Notifications',
          //       style: TextStyle(
          //         fontSize: 18,
          //         fontWeight: FontWeight.bold,
          //       ),
          //     )
          //   ],
          // ),
          // Divider(
          //   height: 15,
          //   thickness: 2,
          // ),
          // SizedBox(
          //   height: 15,
          // ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Text(
          //       'New for you',
          //       style: TextStyle(
          //         fontSize: 18,
          //         fontWeight: FontWeight.w500,
          //         color: Colors.grey,
          //       ),
          //     ),
          //     Switch(
          //       activeColor: Theme.of(context).primaryColor,
          //       value: true,
          //       onChanged: (bool val) {},
          //     ),
          //   ],
          // ),
          // Container(
          //   padding: EdgeInsets.symmetric(horizontal: 40),
          //   child: ElevatedButton(
          //       style: ElevatedButton.styleFrom(
          //         onPrimary: Colors.red,
          //         primary: Theme.of(context).primaryColor,
          //         shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(20),
          //         ),
          //       ),
          //       child: Text(
          //         'SIGN OUT',
          //         style: TextStyle(
          //           color: Colors.white,
          //         ),
          //       ),
          //       onPressed: () {
          //         context
          //             .read<AuthenticationBloc>()
          //             .add(AuthenticationLogoutRequested());
          //       }),
          // ),
        ],
      ),
    );
  }
}
