import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:vitamed/main.dart';

class FirebaseApi {
  final _firebaseMesange = FirebaseMessaging.instance;
  Future<void> initNotifications() async {
    await _firebaseMesange.requestPermission();
  }
}

Future<void> handleBackGroundMessange(RemoteMessage message) async {
  print('Title : ${message.notification?.title}');
  print('Body : ${message.notification?.body}');
  print('PayLoad : ${message.data}');
}

// /// Create a [AndroidNotificationChannel] for heads up notifications
// late AndroidNotificationChannel channel;

// bool isFlutterLocalNotificationsInitialized = false;

// Future<void> setupFlutterNotifications() async {
//   if (isFlutterLocalNotificationsInitialized) {
//     return;
//   }
//   channel = const AndroidNotificationChannel(
//     'vitamed', // id
//     'High Importance Notifications', // title
//     description:
//         'This channel is used for important notifications.', // description
//     importance: Importance.high,
//   );

//   final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

//   /// Create an Android Notification Channel.
//   ///
//   /// We use this channel in the `AndroidManifest.xml` file to override the
//   /// default FCM channel to enable heads up notifications.
//   await flutterLocalNotificationsPlugin
//       .resolvePlatformSpecificImplementation<
//           AndroidFlutterLocalNotificationsPlugin>()
//       ?.createNotificationChannel(channel);

//   /// Update the iOS foreground notification presentation options to allow
//   /// heads up notifications.
//   await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
//       alert: true, badge: true, sound: true);
//   isFlutterLocalNotificationsInitialized = true;
// }

void showFlutterNotification(RemoteMessage message) {
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;
  if (notification != null && android != null && !kIsWeb) {
    // flutterLocalNotificationsPlugin.show(
    //   notification.hashCode,
    //   notification.title,
    //   notification.body,
    //   // NotificationDetails(
    //   //   android: AndroidNotificationDetails(
    //   //     channel.id,
    //   //     channel.name,
    //   //     channelDescription: channel.description,
    //   //     // TODO add a proper drawable resource to android, for now using
    //   //     //      one that already exists in example app.
    //   //     icon: 'launch_background',
    //   //   ),
    //   // ),
    // );
  }
}



// dP9PrKFkSZO4cSP1CuVvUs:APA91bH4yXEOmah9xAt2lhe46oGyLt8upC0KmZyJ3qyc6NJbFjrc-JSd8PHys_dpljYOirznQOBt7JTGGR6wqSe3Ekr1AeIViY5izaRuNhUPc_l4CP88Azs