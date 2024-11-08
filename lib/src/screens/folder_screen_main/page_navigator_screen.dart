import 'package:flutter/material.dart';
import 'package:vitamed/src/screens/folder_profile/screen_profiles.dart';
import 'package:vitamed/src/screens/folder_screen_main/home_screen.dart';

import '../folder_screen_doctors/screen_doctor_main.dart';

class PageNavigatorScreen extends StatefulWidget {
  const PageNavigatorScreen({super.key});

  @override
  State<PageNavigatorScreen> createState() => _PageNavigatorScreenState();
}

class _PageNavigatorScreenState extends State<PageNavigatorScreen> {
  int _currentIndex = 0;

  // Lista de widgets para las diferentes pestañas
  final List<Widget> _pages = [
    MyHomePage(title: 'Vitamed'),
    ScreenDoctorMain(),
    Center(child: Text('Favorites Screen')),
    ScreenProfiles(),
  ];

  // Función para actualizar la pestaña seleccionada
  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[
          _currentIndex], // Muestra el contenido de la pestaña seleccionada
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_hospital),
            label: 'Doctores',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

// var Doctores = {
//   'nombre': 'Dr. Anadelis Grullón Tejada',
//   'especialidades': 'Pediatra, Nutrición Pediatra',
//   'intitulos': 'Centro Médico Guadalupe',
//   'num_consultorio': 'CMG-301',
//   'exequatur': '489-14',
//   'telefono': '809-578-2215 Ext. 3302',
//   'horarios': 'Lunes a Viernes 8:00am ,1:00pm',
//   'security_health': 'Renacer, Reservas, Metasalud, Simag, APS, GMA, Monumental, ASEMAP, Universal, Mapfre, Humano, UASD, Semma, CMD, Futuro, Senasa',
//   'created_at': '18-10-2024',
// };
