import 'package:capstone_mobile/src/services/firebase/message.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class FirebaseNotification {
  FirebaseNotification() {
    firebaseMessaging = FirebaseMessaging();
    messages = [];
  }

  FirebaseMessaging firebaseMessaging;
  List<Message> messages;

  configFirebaseMessaging() {
    firebaseMessaging.subscribeToTopic('test');

    firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('onMessage: $message');
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('onLaunch: $message');
      },
      onResume: (Map<String, dynamic> message) async {
        print('onResume: $message');
      },
    );
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
    return Scaffold(
      body: ListView(
        children: messages
            .map((message) => ListTile(
                  title: Text(message.title),
                  subtitle: Text(message.body),
                ))
            .toList(),
      ),
    );
  }
}
