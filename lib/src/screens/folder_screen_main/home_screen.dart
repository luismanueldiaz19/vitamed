import 'package:flutter/material.dart';
import 'package:vitamed/src/screens/folder_screen_main/widget/card_consultation.dart';
import 'package:vitamed/src/screens/folder_screen_main/widget/widget_dividores.dart';
import '../../services/auth_service.dart';
import 'widget/my_widget_head.dart';
import 'widget/specialization_list_widget.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // final keyScaffold = GlobalKey<ScaffoldState>();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme;
    final urlDocto =
        'https://images.theconversation.com/files/304957/original/file-20191203-66986-im7o5.jpg?ixlib=rb-4.1.0&q=45&auto=format&w=926&fit=clip';
    final otherDocto =
        "https://cdn-ilabeod.nitrocdn.com/zUukpeMBluXkpSlgUMMfQZYBzJcUmlOw/assets/images/optimized/rev-64c54d1/russell6437.wpenginepowered.com/wp-content/uploads/2020/04/What-Is-An-Orthopedic-Doctor-In-Brooklyn.jpg";

    print(
        'usuario desde el Home para el head :${_authService.currentUser.toString()}');
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: kTextTabBarHeight),
          MyWidgetHead(currenUser: _authService.currentUser),
          MyWidgetDivisores(onPressed: () {}, title: 'Next Consultation'),
          CardConsultation(imageUrl: urlDocto),
          const SizedBox(height: 10),
          CardConsultation(imageUrl: otherDocto),
          MyWidgetDivisores(onPressed: () {}, title: 'Specializations'),
          Expanded(child: SpecializationsList()),
        ],
      ),
    );
  }
}
