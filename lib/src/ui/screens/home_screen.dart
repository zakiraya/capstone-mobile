import 'package:capstone_mobile/src/ui/widgets/navigation_bar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(
      settings: RouteSettings(name: "/Home"),
      builder: (_) => HomeScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return NavigationBar();
    // Scaffold(
    //   appBar: AppBar(title: const Text('Home')),
    //   body: Center(
    //     child: Column(
    //       mainAxisSize: MainAxisSize.min,
    //       children: <Widget>[
    //         Builder(
    //           builder: (context) {
    //             final userId = context.select(
    //               (AuthenticationBloc bloc) => bloc.state.user.id,
    //             );
    //             return Text('UserID: $userId');
    //           },
    //         ),
    //         RaisedButton(
    //           child: const Text('Logout'),
    //           onPressed: () {
    //             context
    //                 .read<AuthenticationBloc>()
    //                 .add(AuthenticationLogoutRequested());
    //           },
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
