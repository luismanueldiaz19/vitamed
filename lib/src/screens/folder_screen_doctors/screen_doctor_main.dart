import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vitamed/src/providers/provider_doctor.dart';
import 'package:vitamed/src/utils/helpers.dart';

import '../../models/doctor.dart';
import '../../utils/constants.dart';
import 'widget/card_doctor.dart';

class ScreenDoctorMain extends StatefulWidget {
  const ScreenDoctorMain({super.key});

  @override
  State<ScreenDoctorMain> createState() => _ScreenDoctorMainState();
}

class _ScreenDoctorMainState extends State<ScreenDoctorMain> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ProviderDoctor>(context, listen: false).fetchDoctors();
    });
  }

  final List<Map<String, dynamic>> doctors = [
    {
      "nombre": "Dra. Ginette Cuevas Guzmán",
      "especialidad": "Medicina Interna",
      "centro": "Centro Médico Guadalupe",
      "codigo": "CMG-127",
      "cedula": "725-09",
      "telefono": "809-578-2216 Ext. 2127",
      "horarios": "Lunes a Jueves: 9:00am – 12:00pm",
      "star": "4.3",
      "image_profile":
          "https://t4.ftcdn.net/jpg/03/08/95/89/360_F_308958931_230NowzijT8bGskds47afzmUTvgbrZWk.jpg",
      "comment": [
        {
          "cliente": "luis manuel",
          "comment": "Buen trabajo",
          "date_time": "03:12",
          "like": "false",
        },
        {
          "cliente": "Maria",
          "comment": "excelente servicios de doctor. muy amable y sincero.",
          "date_time": "22:15",
          "like": "true",
        },
      ],
      "seguros": [
        "Humano",
        "Primera",
        "Mapfre",
        "Senasa",
        "Monumental",
        "Futuro",
        "Renacer",
        "Banreservas",
        "AP",
        "Yunen"
      ]
    },
    {
      "nombre": "Dra. Jose Manuel Sosa",
      "especialidad": "Cirujano Pediatra y Neonatal",
      "centro": "Hospital Cabral Baez",
      "codigo": "CMG-127",
      "cedula": "725-09",
      "telefono": "809-578-2216 Ext. 2127",
      "horarios": "Lunes a Jueves: 9:00am – 12:00pm",
      "star": "4.3",
      "image_profile":
          "https://regencyhealthcare.in/wp-content/uploads/2022/07/doctor-banner-new-2-899.png",
      "comment": [
        {
          "cliente": "luis manuel",
          "comment": "Buen trabajo",
          "date_time": "03:12",
          "like": "false",
        },
        {
          "cliente": "Maria",
          "comment": "excelente servicios de doctor. muy amable y sincero.",
          "date_time": "22:15",
          "like": "true",
        },
      ],
      "seguros": [
        "Humano",
        "Primera",
        "Mapfre",
      ]
    },
    {
      "nombre": "Dra. Ginette Cuevas Guzmán",
      "especialidad": "Medicina Interna",
      "centro": "Centro Médico Guadalupe",
      "codigo": "CMG-127",
      "cedula": "725-09",
      "telefono": "809-578-2216 Ext. 2127",
      "horarios": "Lunes a Jueves: 9:00am – 12:00pm",
      "star": "4.3",
      "image_profile":
          "https://t4.ftcdn.net/jpg/03/08/95/89/360_F_308958931_230NowzijT8bGskds47afzmUTvgbrZWk.jpg",
      "comment": [
        {
          "cliente": "luis manuel",
          "comment": "Buen trabajo",
          "date_time": "03:12",
          "like": "false",
        },
        {
          "cliente": "Maria",
          "comment": "excelente servicios de doctor. muy amable y sincero.",
          "date_time": "22:15",
          "like": "true",
        },
      ],
      "seguros": [
        "Humano",
        "Primera",
        "Mapfre",
        "Senasa",
        "Monumental",
        "Futuro",
        "Renacer",
        "Banreservas",
        "AP",
        "Yunen"
      ]
    },
    {
      "nombre": "Dra. Jose Manuel Sosa",
      "especialidad": "Cirujano Pediatra y Neonatal",
      "centro": "Hospital Cabral Baez",
      "codigo": "CMG-127",
      "cedula": "725-09",
      "telefono": "809-578-2216 Ext. 2127",
      "horarios": "Lunes a Jueves: 9:00am – 12:00pm",
      "star": "4.3",
      "image_profile":
          "https://regencyhealthcare.in/wp-content/uploads/2022/07/doctor-banner-new-2-899.png",
      "comment": [
        {
          "cliente": "luis manuel",
          "comment": "Buen trabajo",
          "date_time": "03:12",
          "like": "false",
        },
        {
          "cliente": "Maria",
          "comment": "excelente servicios de doctor. muy amable y sincero.",
          "date_time": "22:15",
          "like": "true",
        },
      ],
      "seguros": [
        "Humano",
        "Primera",
        "Mapfre",
      ]
    },
    {
      "nombre": "Dra. Ginette Cuevas Guzmán",
      "especialidad": "Medicina Interna",
      "centro": "Centro Médico Guadalupe",
      "codigo": "CMG-127",
      "cedula": "725-09",
      "telefono": "809-578-2216 Ext. 2127",
      "horarios": "Lunes a Jueves: 9:00am – 12:00pm",
      "star": "4.3",
      "image_profile":
          "https://t4.ftcdn.net/jpg/03/08/95/89/360_F_308958931_230NowzijT8bGskds47afzmUTvgbrZWk.jpg",
      "comment": [
        {
          "cliente": "luis manuel",
          "comment": "Buen trabajo",
          "date_time": "03:12",
          "like": "false",
        },
        {
          "cliente": "Maria",
          "comment": "excelente servicios de doctor. muy amable y sincero.",
          "date_time": "22:15",
          "like": "true",
        },
      ],
      "seguros": [
        "Humano",
        "Primera",
        "Mapfre",
        "Senasa",
        "Monumental",
        "Futuro",
        "Renacer",
        "Banreservas",
        "AP",
        "Yunen"
      ]
    },
    {
      "nombre": "Dra. Jose Manuel Sosa",
      "especialidad": "Cirujano Pediatra y Neonatal",
      "centro": "Hospital Cabral Baez",
      "codigo": "CMG-127",
      "cedula": "725-09",
      "telefono": "809-578-2216 Ext. 2127",
      "horarios": "Lunes a Jueves: 9:00am – 12:00pm",
      "star": "4.3",
      "image_profile":
          "https://regencyhealthcare.in/wp-content/uploads/2022/07/doctor-banner-new-2-899.png",
      "comment": [
        {
          "cliente": "luis manuel",
          "comment": "Buen trabajo",
          "date_time": "03:12",
          "like": "false",
        },
        {
          "cliente": "Maria",
          "comment": "excelente servicios de doctor. muy amable y sincero.",
          "date_time": "22:15",
          "like": "true",
        },
      ],
      "seguros": [
        "Humano",
        "Primera",
        "Mapfre",
      ]
    },
    {
      "nombre": "Dra. Ginette Cuevas Guzmán",
      "especialidad": "Medicina Interna",
      "centro": "Centro Médico Guadalupe",
      "codigo": "CMG-127",
      "cedula": "725-09",
      "telefono": "809-578-2216 Ext. 2127",
      "horarios": "Lunes a Jueves: 9:00am – 12:00pm",
      "star": "4.3",
      "image_profile":
          "https://t4.ftcdn.net/jpg/03/08/95/89/360_F_308958931_230NowzijT8bGskds47afzmUTvgbrZWk.jpg",
      "comment": [
        {
          "cliente": "luis manuel",
          "comment": "Buen trabajo",
          "date_time": "03:12",
          "like": "false",
        },
        {
          "cliente": "Maria",
          "comment": "excelente servicios de doctor. muy amable y sincero.",
          "date_time": "22:15",
          "like": "true",
        },
      ],
      "seguros": [
        "Humano",
        "Primera",
        "Mapfre",
        "Senasa",
        "Monumental",
        "Futuro",
        "Renacer",
        "Banreservas",
        "AP",
        "Yunen"
      ]
    },
    {
      "nombre": "Dra. Jose Manuel Sosa",
      "especialidad": "Cirujano Pediatra y Neonatal",
      "centro": "Hospital Cabral Baez",
      "codigo": "CMG-127",
      "cedula": "725-09",
      "telefono": "809-578-2216 Ext. 2127",
      "horarios": "Lunes a Jueves: 9:00am – 12:00pm",
      "star": "4.3",
      "image_profile":
          "https://regencyhealthcare.in/wp-content/uploads/2022/07/doctor-banner-new-2-899.png",
      "comment": [
        {
          "cliente": "luis manuel",
          "comment": "Buen trabajo",
          "date_time": "03:12",
          "like": "false",
        },
        {
          "cliente": "Maria",
          "comment": "excelente servicios de doctor. muy amable y sincero.",
          "date_time": "22:15",
          "like": "true",
        },
      ],
      "seguros": [
        "Humano",
        "Primera",
        "Mapfre",
      ]
    },
    {
      "nombre": "Dra. Ginette Cuevas Guzmán",
      "especialidad": "Medicina Interna",
      "centro": "Centro Médico Guadalupe",
      "codigo": "CMG-127",
      "cedula": "725-09",
      "telefono": "809-578-2216 Ext. 2127",
      "horarios": "Lunes a Jueves: 9:00am – 12:00pm",
      "star": "4.3",
      "image_profile":
          "https://t4.ftcdn.net/jpg/03/08/95/89/360_F_308958931_230NowzijT8bGskds47afzmUTvgbrZWk.jpg",
      "comment": [
        {
          "cliente": "luis manuel",
          "comment": "Buen trabajo",
          "date_time": "03:12",
          "like": "false",
        },
        {
          "cliente": "Maria",
          "comment": "excelente servicios de doctor. muy amable y sincero.",
          "date_time": "22:15",
          "like": "true",
        },
      ],
      "seguros": [
        "Humano",
        "Primera",
        "Mapfre",
        "Senasa",
        "Monumental",
        "Futuro",
        "Renacer",
        "Banreservas",
        "AP",
        "Yunen"
      ]
    },
    {
      "nombre": "Dra. Jose Manuel Sosa",
      "especialidad": "Cirujano Pediatra y Neonatal",
      "centro": "Hospital Cabral Baez",
      "codigo": "CMG-127",
      "cedula": "725-09",
      "telefono": "809-578-2216 Ext. 2127",
      "horarios": "Lunes a Jueves: 9:00am – 12:00pm",
      "star": "4.3",
      "image_profile":
          "https://regencyhealthcare.in/wp-content/uploads/2022/07/doctor-banner-new-2-899.png",
      "comment": [
        {
          "cliente": "luis manuel",
          "comment": "Buen trabajo",
          "date_time": "03:12",
          "like": "false",
        },
        {
          "cliente": "Maria",
          "comment": "excelente servicios de doctor. muy amable y sincero.",
          "date_time": "22:15",
          "like": "true",
        },
      ],
      "seguros": [
        "Humano",
        "Primera",
        "Mapfre",
      ]
    },
    {
      "nombre": "Dra. Ginette Cuevas Guzmán",
      "especialidad": "Medicina Interna",
      "centro": "Centro Médico Guadalupe",
      "codigo": "CMG-127",
      "cedula": "725-09",
      "telefono": "809-578-2216 Ext. 2127",
      "horarios": "Lunes a Jueves: 9:00am – 12:00pm",
      "star": "4.3",
      "image_profile":
          "https://t4.ftcdn.net/jpg/03/08/95/89/360_F_308958931_230NowzijT8bGskds47afzmUTvgbrZWk.jpg",
      "comment": [
        {
          "cliente": "luis manuel",
          "comment": "Buen trabajo",
          "date_time": "03:12",
          "like": "false",
        },
        {
          "cliente": "Maria",
          "comment": "excelente servicios de doctor. muy amable y sincero.",
          "date_time": "22:15",
          "like": "true",
        },
      ],
      "seguros": [
        "Humano",
        "Primera",
        "Mapfre",
        "Senasa",
        "Monumental",
        "Futuro",
        "Renacer",
        "Banreservas",
        "AP",
        "Yunen"
      ]
    },
    {
      "nombre": "Dra. Jose Manuel Sosa",
      "especialidad": "Cirujano Pediatra y Neonatal",
      "centro": "Hospital Cabral Baez",
      "codigo": "CMG-127",
      "cedula": "725-09",
      "telefono": "809-578-2216 Ext. 2127",
      "horarios": "Lunes a Jueves: 9:00am – 12:00pm",
      "star": "4.3",
      "image_profile":
          "https://regencyhealthcare.in/wp-content/uploads/2022/07/doctor-banner-new-2-899.png",
      "comment": [
        {
          "cliente": "luis manuel",
          "comment": "Buen trabajo",
          "date_time": "03:12",
          "like": "false",
        },
        {
          "cliente": "Maria",
          "comment": "excelente servicios de doctor. muy amable y sincero.",
          "date_time": "22:15",
          "like": "true",
        },
      ],
      "seguros": [
        "Humano",
        "Primera",
        "Mapfre",
      ]
    },
  ];
  @override
  Widget build(BuildContext context) {
    final doctorList =
        Provider.of<ProviderDoctor>(context, listen: true).doctorListFilter;
    final providerData = Provider.of<ProviderDoctor>(context, listen: false);
    final style = Theme.of(context).textTheme;
    final testo =
        "Es un hecho establecido hace demasiado tiempo que un lector se distraerá con el contenido del texto de un sitio mientras que mira su diseño. El punto de usar Lorem Ipsum es que tiene una distribución más o menos normal de las letras, al contrario de usar textos como por ejemplo ";
    return Column(children: [
      const SizedBox(height: kToolbarHeight),
      Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Doctores',
                    style: fontTitle.copyWith(
                        fontSize: style.titleLarge?.fontSize)),
                Text('Empieza a buscar',
                    style: fontBody?.copyWith(color: Colors.black54))
              ],
            ),
          )
        ],
      ),
      CustomTextField(
          icon: Icons.search, labelText: 'Buscar', onChanged: (value) {}),
      // TextButton(
      //     onPressed: () async {
      //       // final doctor = {
      //       //   'nombre': 'Dr. Anadelis Grullón Tejada',
      //       //   'especialidades': 'Pediatra, Nutrición Pediatra',
      //       //   'institucion': 'Centro Médico Guadalupe',
      //       //   'num_consultorio': 'CMG-301',
      //       //   'exequatur': '489-14',
      //       //   'telefono': '809-578-2215 Ext. 3302',
      //       //   'horarios': 'Lunes a Viernes 8:00am - 1:00pm',
      //       //   'security_health':
      //       //       'Renacer, Reservas, Metasalud, Simag, APS, GMA, Monumental, ASEMAP, Universal, Mapfre, Humano, UASD, Semma, CMD, Futuro, Senasa',
      //       //   'created_at': '18-10-2024',
      //       // };

      //       final item = {
      //         "nombre": "Dra. Ginette Cuevas Guzmán",
      //         "especialidad": "Medicina Interna",
      //         "centro": "Centro Médico Guadalupe",
      //         "codigo": "CMG-127",
      //         "cedula": "725-09",
      //         "telefono": "809-578-2216 Ext. 2127",
      //         "horarios": "Lunes a Jueves: 9:00am – 12:00pm",
      //         "star": "4.3",
      //         "informacion": testo,
      //         "is_favorite" : false,
      //         "image_profile":
      //             "https://t4.ftcdn.net/jpg/03/08/95/89/360_F_308958931_230NowzijT8bGskds47afzmUTvgbrZWk.jpg",
      //         "comment": [
      //           {
      //             "cliente": "luis manuel",
      //             "comment": "Buen trabajo",
      //             "date_time": "03:12",
      //             "like": "false"
      //           },
      //           {
      //             "cliente": "Maria",
      //             "comment":
      //                 "excelente servicios de doctor. muy amable y sincero.",
      //             "date_time": "22:15",
      //             "like": "true"
      //           },
      //         ],
      //         "seguros": [
      //           "Humano",
      //           "Primera",
      //           "Mapfre",
      //           "Senasa",
      //           "Monumental",
      //           "Futuro",
      //           "Renacer",
      //           "Banreservas",
      //           "AP",
      //           "Yunen"
      //         ]
      //       };
      //       await Provider.of<ProviderDoctor>(context, listen: false)
      //           .addDoctor(item);
      //     },
      //     child: Text('Crear Doctor')),

      // doctorList.isEmpty
      //     ? Center(child: CircularProgressIndicator())
      //     : Expanded(
      //         child: ListView.builder(
      //           itemCount: doctorList.length,
      //           itemBuilder: (context, index) {
      //             Doctor doctor = doctorList[index];
      //             return ListTile(
      //               onTap: () {
      //                 print('Doctor : ${doctor.toJson()}');
      //               },
      //               title: Text(doctor.nombre),
      //               subtitle: Text(doctor.especialidades),
      //               trailing: Text(doctor.telefono),
      //               leading: IconButton(
      //                   onPressed: () {
      //                     providerData.deleteDoctor(doctor.id);
      //                   },
      //                   icon: Icon(Icons.delete)),
      //             );
      //           },
      //         ),
      //       ),

      doctorList.isEmpty
          ? Center(child: CircularProgressIndicator())
          : Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 9 / 16,
                  ),
                  itemCount: doctorList.length,
                  itemBuilder: (context, index) {
                    Doctor item = doctorList[index];
                    return DoctorCard(doctor: item);
                  },
                ),
              ),
            ),
    ]);
  }
}



// {
//   "doctors": {
//     "doctorId1": {
//       "nombre": "Dr. Anadelis Grullón Tejada",
//       "especialidades": "Pediatra, Nutrición Pediatra",
//       "intitulos": "Centro Médico Guadalupe",
//       "num_consultorio": "CMG-301",
//       "exequatur": "489-14",
//       "telefono": "809-578-2215 Ext. 3302",
//       "horarios": "Lunes a Viernes 8:00am ,1:00pm",
//       "security_health": "Renacer, Reservas, Metasalud, Simag, APS, GMA, Monumental, ASEMAP, Universal, Mapfre, Humano, UASD, Semma, CMD, Futuro, Senasa",
//       "created_at": "18-10-2024"
//     },

//   }
// }
