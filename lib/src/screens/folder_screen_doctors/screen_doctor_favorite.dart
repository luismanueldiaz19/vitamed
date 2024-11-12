import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:vitamed/src/models/doctor.dart';

import '../../providers/provider_doctor.dart';

class ScreenDoctorFavorite extends StatefulWidget {
  const ScreenDoctorFavorite({super.key});

  @override
  State<ScreenDoctorFavorite> createState() => _ScreenDoctorFavoriteState();
}

class _ScreenDoctorFavoriteState extends State<ScreenDoctorFavorite> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ProviderDoctor>(context, listen: false)
          .fetchDoctorsFavorite();
    });
  }

  @override
  Widget build(BuildContext context) {
    final listFavorite = context.watch<ProviderDoctor>().doctorListFavorite;
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: listFavorite.length,
            itemBuilder: (BuildContext context, int index) {
              Doctor item = listFavorite[index];
              return ListTile(
                title: Text(item.nombre ?? 'N/A'),
                subtitle: Text(item.especialidad ?? 'N/A'),
              );
            },
          ),
        ),
      ],
    );
  }
}
