import 'package:capstone_mobile/src/services/firebase/message.dart';
import 'package:capstone_mobile/src/ui/screens/login_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

class FirebaseNotification {
  // FirebaseNotification() {
  //   firebaseMessaging = FirebaseMessaging();
  //   messages = [];
  // }

  static Future<void> myBackgroundMessageHandler(Map<String, dynamic> message) {
    print('on background $message');
    return null;
  }

  static FirebaseMessaging firebaseMessaging = FirebaseMessaging();
  static List<Message> messages = [];
  static String topic = '';

  static void unsubscribeFromTopic() {
    if (topic.isNotEmpty) {
      print("unsubscribeFromTopic");
      print(topic);
      firebaseMessaging.unsubscribeFromTopic(topic);
    }
  }

  static Future configFirebaseMessaging(NavigatorState navigator) async {
    if (topic.isNotEmpty) {
      print("subscribeToTopic");
      print(topic);
      firebaseMessaging.subscribeToTopic(topic);
      firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
          print('onMessage: $message');
        },
        onBackgroundMessage: myBackgroundMessageHandler,
        onLaunch: (Map<String, dynamic> message) async {
          print('onLaunch: $message');
          navigator.push(LoginScreen.route());
        },
        onResume: (Map<String, dynamic> message) async {
          print('onResume: $message');
        },
      );
    }
  }

  @override
  List<Object> get props => [
        firebaseMessaging,
        messages,
      ];
}

class MessagingWidget extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => MessagingWidget());
  }

  @override
  _MessagingWidgetState createState() => _MessagingWidgetState();
}

class _MessagingWidgetState extends State<MessagingWidget> {
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging();
  final List<Message> messages = [];
  static Future<void> myBackgroundMessageHandler(Map<String, dynamic> message) {
    print('on background $message');
    return null;
  }

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  void initState() {
    super.initState();

    firebaseMessaging.subscribeToTopic('test');

    firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('onMessage: $message');
        final notification = message['notification'];
        setState(() {
          messages.add(Message(
              title: notification['title'], body: notification['body']));
        });
      },
      onBackgroundMessage: myBackgroundMessageHandler,
      onLaunch: (Map<String, dynamic> message) async {
        print('onLaunch: $message');
      },
      onResume: (Map<String, dynamic> message) async {
        print('onResume: $message');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            body: Container(
              child: Text('Error'),
            ),
          );
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return Scaffold(
            body: ListView(
              children: messages
                  .map((message) => ListTile(
                        title: Text(message.title ?? 'test'),
                        subtitle: Text(message.body ?? 'test'),
                      ))
                  .toList(),
            ),
          );
        }

        return CircularProgressIndicator();
      },
    );
  }
}
