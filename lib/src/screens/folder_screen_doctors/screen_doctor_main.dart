import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vitamed/src/providers/provider_doctor.dart';
import 'package:vitamed/src/utils/helpers.dart';
import 'package:vitamed/src/widgets/loading.dart';

import '../../models/doctor.dart';
import '../../utils/constants.dart';
import '../../widget/specialization_list_widget.dart';
import '../../widget/widget_dividores.dart';
import 'widget/card_doctor.dart';

class ScreenDoctorMain extends StatefulWidget {
  const ScreenDoctorMain({super.key});

  @override
  State<ScreenDoctorMain> createState() => _ScreenDoctorMainState();
}

class _ScreenDoctorMainState extends State<ScreenDoctorMain> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ProviderDoctor>(context, listen: false).fetchDoctors();
    });
  }

  @override
  Widget build(BuildContext context) {
    final doctorList =
        Provider.of<ProviderDoctor>(context, listen: true).doctorListFilter;
    final providerData = Provider.of<ProviderDoctor>(context, listen: false);
    final style = Theme.of(context).textTheme;
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
          icon: Icons.search,
          labelText: 'Buscar',
          onChanged: (filter) => providerData.searchingDoctor(filter)),
      MyWidgetDivisores(onPressed: () {}, title: 'Especializaciones'),
      SpecializationsList(),
      doctorList.isEmpty
          ? Expanded(
              child: Center(
                  child: LoadingCustom(text: 'No hay datos', isLoading: false)))
          : Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 0,
                      childAspectRatio: 9 / 16),
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
