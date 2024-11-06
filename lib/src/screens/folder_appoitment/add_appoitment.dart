import 'package:flutter/material.dart';
import 'package:vitamed/src/utils/constants.dart';
import 'package:intl/intl.dart';
import '../../models/doctor.dart';

class AddAppoitment extends StatefulWidget {
  const AddAppoitment({super.key, this.doctor});
  final Doctor? doctor;
  @override
  State<AddAppoitment> createState() => _AddAppoitmentState();
}

class _AddAppoitmentState extends State<AddAppoitment> {
  DateTime selectedDate = DateTime.now();
  List<String> days = [];
  Map<String, bool> disponibilidad = {};
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
    });
  }

  appoitment() async {}

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme;
    print(widget.doctor?.toJson());
    final sized = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
          title: const Text('Agendar cita'), backgroundColor: Colors.white),
      body: Column(
        children: [
          const SizedBox(height: kToolbarHeight, width: double.infinity),
          Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.doctor?.nombre ?? 'N/A',
                  style:
                      style.titleLarge?.copyWith(fontWeight: FontWeight.bold),
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
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                Icon(Icons.arrow_back_ios_new_rounded,
                    color: Colors.black38, size: style.titleLarge?.fontSize),
                const SizedBox(width: 10),
                Text('Septiembres'),
                const SizedBox(width: 10),
                IconButton(
                    onPressed: _selectMonth,
                    icon: Icon(Icons.arrow_forward_ios_outlined)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Container(
                height: 100,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: days.length,
                    itemBuilder: (context, index) {
                      return Container(
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
                            crossAxisAlignment: CrossAxisAlignment.center,
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
                      );
                    })),
          ),

          Divider(
            color: Colors.grey.shade300,
            indent: sized.width * 0.05,
            endIndent: sized.width * 0.05,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4, // Máximo de 3 columnas
                  childAspectRatio: 2.5, // Más ancho que alto
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: disponibilidad.length,
                itemBuilder: (context, index) {
                  String hora = disponibilidad.keys.elementAt(index);
                  bool esDisponible = disponibilidad[hora] ?? false;

                  return TextButton(
                    onPressed: esDisponible ? appoitment : null,
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: esDisponible ? softCyan : mutedGrayGreen,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        hora,
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: SizedBox(
              width: sized.width,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          AddAppoitment(doctor: widget.doctor!),
                    ),
                  );
                },
                child: Text(
                  'Cita'.toUpperCase(),
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
