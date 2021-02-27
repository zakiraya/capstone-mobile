import 'package:capstone_mobile/src/blocs/violation/violation_bloc.dart';
import 'package:capstone_mobile/src/blocs/violation_filter/violation_filter_bloc.dart';
import 'package:capstone_mobile/src/ui/widgets/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(
      settings: RouteSettings(name: "/Home"),
      builder: (_) => HomeScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ViolationFilterBloc(
          violationBloc: BlocProvider.of<ViolationBloc>(context)),
      child: NavigationBar(),
    );
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
