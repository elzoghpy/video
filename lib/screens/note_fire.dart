// ignore_for_file: avoid_print

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_send/api/firebase_api.dart';
import 'package:flutter/material.dart';

class NotificationSreens extends StatefulWidget {
  const NotificationSreens({super.key});

  @override
  State<NotificationSreens> createState() => _NotificationSreensState();
}

class _NotificationSreensState extends State<NotificationSreens> {
  final _firebaseMessaging = FirebaseMessaging.instance;

  getToken() async {
    String? fcmToken = await _firebaseMessaging.getToken();
    print("=============================================");
    print('Token : $fcmToken');
  }

  myRequestPermisson() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    print('User granted permission: ${settings.authorizationStatus}');
  }

  @override
  void initState() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');

        NotificationService.showNotification(message);
      }
    });
    myRequestPermisson();
    getToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.green,
        title: const Center(
          child: Text(
            'FirebaseNotification',
            style: TextStyle(color: Colors.white, fontSize: 30),
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Center(
            child: InkWell(
              onTap: () {},
              child: const SizedBox(
                width: 300,
                height: 80,
                child: Card(
                  color: Colors.green,
                  child: Center(
                    child: Text(
                      'Notification',
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
