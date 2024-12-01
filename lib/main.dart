import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:vitamed/src/providers/provider_citas.dart';
import 'package:vitamed/src/providers/provider_usuario.dart';
import 'package:vitamed/src/screens/splash_screen.dart';
import 'package:vitamed/src/services/notification_service.dart';
import 'firebase_options.dart';
import 'src/providers/provider_doctor.dart';
import 'src/providers/provider_recetas.dart';
import 'src/services/firebase_api.dart';
import 'src/utils/constants.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//     FlutterLocalNotificationsPlugin();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseApi().initNotifications();
  await NotificationService.initNotifi();

  // const AndroidInitializationSettings initializationSettingsAndroid =
  //     AndroidInitializationSettings('@mipmap/ic_launcher');
  // const InitializationSettings initializationSettings =
  //     InitializationSettings(android: initializationSettingsAndroid);

  // await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  await FirebaseMessaging.instance.setAutoInitEnabled(true);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProviderDoctor()),
        ChangeNotifierProvider(create: (_) => ProviderCita()),
        ChangeNotifierProvider(create: (_) => ProviderRecetas()),
        ChangeNotifierProvider(create: (_) => providerUsuario()),
        // ChangeNotifierProvider(create: (_) => ProjectEarthProvider()),
        // ProjectEarthProvider
        // RentaCarProvider
      ],
      child: const MyApp(),
    ),
  );
}

// const Color deepTeal = Color(0xff1b939b);

// Crea un MaterialColor a partir del color deepTeal
const MaterialColor deepTealMaterial = MaterialColor(
  0xff1b939b,
  <int, Color>{
    50: Color(0xffe0f2f1),
    100: Color(0xffb2dfdb),
    200: Color(0xff80cbc4),
    300: Color(0xff4db6ac),
    400: Color(0xff26a69a),
    500: Color(0xff1b939b), // Color principal
    600: Color(0xff00897b),
    700: Color(0xff00796b),
    800: Color(0xff00695c),
    900: Color(0xff004d40),
  },
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appName,
      theme: ThemeData(
        primarySwatch: deepTealMaterial,
        colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: softCyan,
          onPrimary: Colors.white,
          secondary: lightMintGreen,
          onSecondary: Colors.white,
          background: Colors.white,
          onBackground: Colors.black,
          surface: Colors.grey[50]!,
          onSurface: Colors.black,
          error: Colors.red,
          onError: Colors.white,
        ),
        useMaterial3: true,
      ),
      home: SplashScreen(),
    );
  }
}


  // ElevatedButton(
  //             onPressed: () async {
  //               await NotificationService.showNotificacion(
  //                   title: 'Titulo de notificacion',
  //                   body: 'Body de la notificaciones ');
  //             },
  //             child: Text('Normal Notificacion'),
  //           ),
  //           ElevatedButton(
  //             onPressed: () async {
  //               await NotificationService.showNotificacion(
  //                 title: 'Titulo de notificacion',
  //                 body: 'Body de la notificaciones',
  //                 summary: 'Small Summary',
  //                 notificationLayout: NotificationLayout.Inbox,
  //               );
  //             },
  //             child: Text('Notificacion sumary'),
  //           ),
  //           ElevatedButton(
  //             onPressed: () async {
  //               await NotificationService.showNotificacion(
  //                 title: 'Titulo de notificacion',
  //                 body: 'Body de la notificaciones',
  //                 summary: 'Small Summary',
  //                 notificationLayout: NotificationLayout.Messaging,
  //               );
  //             },
  //             child: Text('Notificacion Mensaje'),
  //           ),
  //           ElevatedButton(
  //             onPressed: () async {
  //               await NotificationService.showNotificacion(
  //                 title: 'Titulo de notificacion',
  //                 body: 'Body de la notificaciones',
  //                 summary: 'Small Summary',
  //                 notificationLayout: NotificationLayout.Messaging,
  //                 scheduled: true,
  //                 interval: 5,
  //               );
  //             },
  //             child: Text('Notificacion Scheduled'),
  //           ),
  //           ElevatedButton(
  //             onPressed: () async {
  //               await NotificationService.showNotificacion(
  //                   title: 'Titulo de notificacion',
  //                   body: 'Body de la notificaciones',
  //                   payload: {
  //                     'navigate': 'true'
  //                   },
  //                   actionButtons: [
  //                     NotificationActionButton(
  //                       key: 'Check',
  //                       label: 'Check it out',
  //                       actionType: ActionType.SilentAction,
  //                       color: Colors.green,
  //                     )
  //                   ]);
  //             },
  //             child: Text('Action Notificacion'),
  //           ),
         
         