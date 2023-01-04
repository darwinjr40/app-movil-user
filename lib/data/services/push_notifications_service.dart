import 'dart:async';
import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/material.dart';
import 'package:micros_user_app/data/services/services.dart';
import 'package:http/http.dart' as http;
import 'package:micros_user_app/env.dart';

// SHA1: 5A:2F:E8:7B:66:B2:C0:25:FA:98:DB:08:14:F3:40:03:9E:EE:99:48
// P8 - KeyID: VYZH37GGZ9

class PushNotificationService {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static String? token;
  static final StreamController<String> _messageStream = StreamController.broadcast();
  static Stream<String> get messagesStream => _messageStream.stream;

  static Future _backgroundHandler(RemoteMessage message) async {
    debugPrint( 'onBackground Handler ${ message.messageId }');
    print(message.data);
    _messageStream.add(message.data['product'] ?? 'No data');
    // _messageStream.add( message.notification?.title ?? 'No title' );
  }

  static Future _onMessageHandler(RemoteMessage message) async {
    debugPrint( 'onMessage Handler ${ message.messageId }');
    print(message.data);
    _messageStream.add(message.data['product'] ?? 'No data');
    // _messageStream.add( message.notification?.title ?? 'No title' );
  }

  static Future _onMessageOpenApp(RemoteMessage message) async {
    debugPrint( 'onMessageOpenApp Handler ${ message.messageId }');
    print(message.data);
    _messageStream.add(message.data['product'] ?? 'No data');
    // _messageStream.add( message.notification?.title ?? 'No title' );
  }

  static Future initializeApp() async {
    // Push Notifications
    await Firebase.initializeApp();
    //   await requestPermission();
    await messaging.getInitialMessage();
    _saveToken();
    
    // Handlers
    FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
    FirebaseMessaging.onMessage.listen(_onMessageHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenApp);

    // Local Notifications
  }

  static void _saveToken() async {
    token = await FirebaseMessaging.instance.getToken();
    debugPrint('Token: $token');
    Map<String, dynamic> data = {"token": token};
    PassengerService.create(data);
  }
  // // Apple / Web
  // static requestPermission() async {
  //   NotificationSettings settings = await messaging.requestPermission(
  //     alert: true,
  //     announcement: false,
  //     badge: true,
  //     carPlay: false,
  //     criticalAlert: false,
  //     provisional: false,
  //     sound: true
  //   );

  //   print('User push notification status ${ settings.authorizationStatus }');

  // }

 static Future<void> sendMessage(String to, Map<String, dynamic> data, String titulo, String texto) async {
    try {
      Map<String, dynamic> $mapa = {
        'notification': {
          'title': titulo,
          'body': texto,
        },
        'priority': 'high',
        'ttl': '4500s',
        'data': data,
        'to': to
      };
      // const url = 'https://fcm.googleapis.com/fcm/send';      
      // final resp =await http.post(
      //   Uri.parse(url),
      //   headers: <String, String> {
      //     'Content-Type': 'application/json',
      //     'Authorization': 'key=sadfsadfsdaf' //aqui va la key del server 
      //   },
      //   body: jsonEncode( $mapa)
      // );
      const url = '${baseUrl}travel-info/send-message';
      final resp = await http.post(
        Uri.parse(url),
        headers: {
          'Accept' : 'application/json',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: jsonEncode($mapa),
        // body: ($mapa),
      );
      if (resp.statusCode != 200) {
        debugPrint('ERROR <sendMessage> :${resp.body}');
      }     
        debugPrint('SUCESS <sendMessage> :${resp.body}');
    } catch (error) {
        debugPrint('ERROR <catch:sendMessage> :${error.toString()}');
      return Future.error(error.toString());
    }
  }

  static closeStreams() {
    _messageStream.close();
  }
}
