import 'package:firebase_messaging/firebase_messaging.dart';

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


// dP9PrKFkSZO4cSP1CuVvUs:APA91bH4yXEOmah9xAt2lhe46oGyLt8upC0KmZyJ3qyc6NJbFjrc-JSd8PHys_dpljYOirznQOBt7JTGGR6wqSe3Ekr1AeIViY5izaRuNhUPc_l4CP88Azs