import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vitamed/src/providers/provider_citas.dart';
import 'package:vitamed/src/utils/constants.dart';
import 'package:intl/intl.dart';
import 'package:vitamed/src/widgets/loading.dart';
import '../../models/doctor.dart';
import '../../services/auth_service.dart';
import 'package:uuid/uuid.dart';

import '../folder_screen_main/home_screen.dart';
import '../folder_screen_main/page_navigator_screen.dart';

class AddAppoitment extends StatefulWidget {
  const AddAppoitment({super.key, this.doctor});
  final Doctor? doctor;
  @override
  State<AddAppoitment> createState() => _AddAppoitmentState();
}

class _AddAppoitmentState extends State<AddAppoitment> {
  final AuthService _authService = AuthService();
  DateTime selectedDate = DateTime.now();
  List<String> days = [];
  String? hourPicked = '';
  String? dayPicked = '01';
  Map<String, bool> disponibilidad = {};
  bool isLoading = false;
  // Genera la lista de días para el mes seleccionado
  void _generateDays() {
    days.clear();
    int daysInMonth =
        DateTime(selectedDate.year, selectedDate.month + 1, 0).day;
    for (int i = 1; i <= daysInMonth; i++) {
      DateTime date = DateTime(selectedDate.year, selectedDate.month, i);
      days.add(
          DateFormat('EEE').format(date) + ' ' + i.toString().padLeft(2, '0'));
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _generateDays();
  }

  // Al seleccionar un día, se actualiza la disponibilidad de horas para ese día
  void _onDaySelected(String day) {
    setState(() {
      disponibilidad = disponibilidadPorDia[day] ?? {};
      dayPicked = day;
      // print('Fecha ${selectedDate.year}-${selectedDate.month}-${day}');
    });
  }

  appoitmentMethod() async {
    if (hourPicked!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Elegir la hora disponible'),
          duration: Duration(seconds: 1),
          backgroundColor: Colors.red,
        ),
      );

      return;
    }
    setState(() {
      isLoading = !isLoading;
    });
    var uuid = Uuid();
    var v1 = uuid.v1();
    var appoitment = {
      'doctor_id': widget.doctor?.id,
      'name_doctor': widget.doctor?.nombre,
      'especialidad': widget.doctor?.especialidad,
      'hour': hourPicked,
      'date': '${selectedDate.year}-${selectedDate.month}-${dayPicked}',
      'usuario_id': _authService.currentUser?.uid,
      'username': _authService.currentUser?.displayName,
      'nota_cita': 'N/A',
      'centro': widget.doctor?.centro,
      'receta_id': v1,
      'is_availablre': true,
      'image_profile_doctor': widget.doctor?.imageProfile,
    };
    print(appoitment);
    await Provider.of<ProviderCita>(context, listen: false).addCita(appoitment);
    await esperar();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => PageNavigatorScreen()),
    );
    // setState(() {
    //   isLoading = !isLoading;
    // });
  }

  void pickTime(hora) {
    setState(() {
      hourPicked = hora;
    });
  }

  Future esperar() async {
    await Future.delayed(const Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme;
    // print(widget.doctor?.toJson());
    final sized = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
          title: const Text('Agendar cita'), backgroundColor: Colors.white),
      body: isLoading
          ? LoadingCustom(
              image: 'assets/icon/logo_vitamed.jpg', text: 'Creando cita')
          : Column(
              children: [
                // const SizedBox(height: kToolbarHeight / 2, width: double.infinity),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: kToolbarHeight / 2, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.doctor?.nombre ?? 'N/A',
                        style: style.titleLarge
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        widget.doctor?.centro ?? 'N/A',
                        style: style.bodySmall?.copyWith(color: oceanBlue),
                      ),
                      Row(
                        children: [
                          Icon(Icons.location_on_outlined,
                              size: style.titleMedium?.fontSize),
                          const SizedBox(width: 10),
                          Row(
                            children: [
                              Text('Distancia '),
                              const SizedBox(width: 5),
                              Text('(2.4Km)'),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
                // const Divider(),

                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: kToolbarHeight / 2),
                  child: Row(
                    children: [
                      Icon(Icons.arrow_back_ios_new_rounded,
                          color: Colors.black38,
                          size: style.titleLarge?.fontSize),
                      const SizedBox(width: 10),
                      Text(DateFormat('MMMM').format(selectedDate)),
                      const SizedBox(width: 10),
                      IconButton(
                          onPressed: _selectMonth,
                          icon: Icon(Icons.arrow_forward_ios_outlined)),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: kToolbarHeight / 3, vertical: 10),
                  child: Container(
                      height: 100,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: days.length,
                          itemBuilder: (context, index) {
                            return ZoomIn(
                              curve: Curves.slowMiddle,
                              duration: const Duration(milliseconds: 300),
                              child: Container(
                                height: 100,
                                width: 60,
                                margin: EdgeInsets.symmetric(horizontal: 5),
                                decoration: BoxDecoration(
                                    color: softCyan,
                                    // color: mutedGrayGreen,
                                    borderRadius: BorderRadius.circular(12)),
                                child: TextButton(
                                  onPressed: () =>
                                      _onDaySelected(days[index].split(" ")[1]),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        days[index].split(" ")[0],
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1.5,
                                          color: Colors.black45,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Text(days[index].split(" ")[1],
                                          style: style.titleMedium?.copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 18))
                                    ],
                                  ),
                                ),
                              ),
                            );
                          })),
                ),

                Divider(
                  color: Colors.grey.shade300,
                  indent: sized.width * 0.05,
                  endIndent: sized.width * 0.05,
                ),
                disponibilidad.length > 1
                    ? Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3, // Máximo de 3 columnas
                              childAspectRatio: 1.5, // Más ancho que alto
                              crossAxisSpacing: 1,
                              mainAxisSpacing: 1,
                            ),
                            itemCount: disponibilidad.length,
                            itemBuilder: (context, index) {
                              String hora =
                                  disponibilidad.keys.elementAt(index);
                              bool esDisponible = disponibilidad[hora] ?? false;
                              int duration =
                                  (Duration.millisecondsPerSecond * index);
                              int time = (duration * 0.10).toInt();
                              // print('duracion : $duration : time : $time');
                              return SlideInLeft(
                                curve: Curves.elasticIn,
                                duration: Duration(milliseconds: time),
                                child: TextButton(
                                  onPressed: esDisponible
                                      ? () => pickTime(hora)
                                      : null,
                                  child: Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: esDisponible
                                          ? skyAquaLight
                                          : Colors.grey,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      hora,
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.white),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      )
                    : Expanded(
                        child: Center(
                            child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.timer_sharp),
                          Text('No hay tiempo previo.')
                        ],
                      ))),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: SizedBox(
                    width: sized.width,
                    child: ElevatedButton(
                      onPressed: appoitmentMethod,
                      child: Text(
                        'Terminar'.toUpperCase(),
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          wordSpacing: 12,
                        ),
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateColor.resolveWith(
                          (states) => darkTeal,
                        ),
                        shape: MaterialStateProperty.resolveWith(
                          (states) => RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  } // Abre el modal para seleccionar el mes

  void _selectMonth() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 300,
          child: ListView.builder(
            itemCount: 12,
            itemBuilder: (context, index) {
              DateTime monthDate = DateTime(selectedDate.year, index + 1);
              String monthName = DateFormat('MMMM').format(monthDate);

              return ListTile(
                title: Text(monthName),
                onTap: () {
                  setState(() {
                    selectedDate = DateTime(selectedDate.year, index + 1);
                    _generateDays();
                  });
                  Navigator.pop(context);
                },
              );
            },
          ),
        );
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
    );
  }
}

// final List<String> horas = [
//   "08:00",
//   "09:00",
//   "10:00",
//   "11:00",
//   "12:00",
//   "13:00",
//   "14:00",
//   "15:00",
//   "16:00",
//   "17:00",
//   "18:00",
//   "19:00",
//   "20:00",
//   "21:00",
//   "22:00"
// ];
final Map<String, Map<String, bool>> disponibilidadPorDia = {
  "01": {
    "08:00": true,
    "09:00": false,
    "10:00": true,
    "11:00": false,
    "12:00": true,
    "13:00": false,
    "14:00": true,
    "15:00": true,
    "16:00": false,
    "17:00": true,
  },
  "02": {
    "08:00": false,
    "09:00": true,
    "10:00": false,
    "11:00": true,
    "12:00": false,
    "13:00": true,
    "14:00": false,
    "15:00": true,
    "16:00": true,
    "17:00": false,
  },
  "03": {
    "08:00": true,
    "09:00": true,
    "10:00": false,
    "11:00": true,
    "12:00": false,
    "13:00": true,
    "14:00": false,
    "15:00": true,
    "16:00": true,
    "17:00": false,
  },
  "04": {
    "08:00": false,
    "09:00": false,
    "10:00": true,
    "11:00": true,
    "12:00": true,
    "13:00": false,
    "14:00": true,
    "15:00": false,
    "16:00": true,
    "17:00": true,
    "18:00": false,
  },
  "05": {
    "08:00": true,
    "09:00": true,
    "10:00": true,
    "11:00": false,
    "12:00": false,
    "13:00": true,
    "14:00": true,
    "15:00": false,
    "16:00": false,
    "17:00": true,
    "18:00": true,
  },
  "06": {
    "08:00": false,
    "09:00": false,
    "10:00": false,
    "11:00": true,
    "12:00": true,
    "13:00": true,
    "14:00": false,
    "15:00": true,
    "16:00": true,
    "17:00": false,
  },
  "07": {
    "08:00": true,
    "09:00": true,
    "10:00": false,
    "11:00": true,
    "12:00": false,
    "13:00": false,
    "14:00": true,
    "15:00": true,
    "16:00": false,
    "17:00": true,
    "18:00": false,
  },
  "08": {
    "08:00": true,
    "09:00": false,
    "10:00": false,
    "11:00": true,
    "12:00": true,
    "13:00": false,
    "14:00": true,
    "15:00": true,
    "16:00": true,
    "17:00": false,
    "18:00": true,
  },
  "09": {
    "08:00": false,
    "09:00": true,
    "10:00": true,
    "11:00": false,
    "12:00": false,
    "13:00": true,
    "14:00": false,
    "15:00": true,
    "16:00": true,
  },
  "10": {
    "08:00": true,
    "09:00": true,
    "10:00": false,
    "11:00": false,
    "12:00": true,
    "13:00": false,
    "14:00": true,
    "15:00": false,
    "16:00": true,
    "17:00": true,
  },
};
