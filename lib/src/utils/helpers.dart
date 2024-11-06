import 'package:flutter/services.dart';
// import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
// import 'package:uuid/uuid.dart';

// import '../models/date_time_range.dart';

// String formatDate(DateTime date) {
//   final DateFormat formatter = DateFormat('yyyy-MM-dd');
//   return formatter.format(date);
// }

bool isValidEmail(String email) {
  final RegExp regex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
  return regex.hasMatch(email);
}

Future<void> showCustomDialog(
    BuildContext context, String title, String message) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(message),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

String formatCurrency(double amount) {
  return '\$${amount.toStringAsFixed(2)}';
}

// String generateUUID() {
//   ///generador de UUID
//   const uuid = Uuid();
//   var idUID = uuid.v4();
//   return idUID;
// }

Widget buildTextField(
    {String? hintText,
    TextEditingController? controller,
    final List<TextInputFormatter>? inputFormatters,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false}) {
  return Container(
    color: Colors.white,
    height: 50,
    width: 250,
    margin: const EdgeInsets.symmetric(vertical: 5),
    child: TextField(
      obscureText: obscureText,
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        hintText: hintText,
        border: InputBorder.none,
        contentPadding: const EdgeInsets.only(left: 15.0),
      ),
    ),
  );
}

Widget buildTextFieldValidator(
    {String? hintText,
    required String label,
    TextEditingController? controller,
    List<TextInputFormatter>? inputFormatters,
    TextInputType keyboardType = TextInputType.text,
    Function? onChanged}) {
  return Container(
    color: Colors.white,
    height: 50,
    width: 250,
    margin: const EdgeInsets.symmetric(vertical: 5),
    child: TextFormField(
      onChanged: onChanged == null ? null : (val) => onChanged(val),
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor, ingrese $label';
        }
        return null;
      },
      decoration: InputDecoration(
          hintText: hintText,
          labelText: label,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 15.0)),
    ),
  );
}

Widget identy(context) => Padding(
      padding: const EdgeInsets.only(bottom: 40, top: 25),
      child: Text("©Vitamed Created by LUDEVELOPER",
          style: Theme.of(context)
              .textTheme
              .bodySmall
              ?.copyWith(color: Colors.black38),
          textAlign: TextAlign.center),
    );
Future waitingTime(Duration duration) async {
  await Future.delayed(duration);
}

Future<DateTime?> showCustomDatePicker(BuildContext context) async {
  DateTime? selectedDate = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2000),
    lastDate: DateTime(2150),
  );

  if (selectedDate != null) {
    return selectedDate;
  }

  return null; // Si no se selecciona ninguna fecha
}

DateTime calculateNextPaymentDate(DateTime startDate, String paymentMode) {
  DateTime nextPaymentDate;

  switch (paymentMode.toLowerCase()) {
    case 'semanal':
      nextPaymentDate = startDate.add(const Duration(days: 7));
      break;
    case 'quincenal':
      nextPaymentDate = startDate.add(const Duration(days: 14));
      break;
    case 'mensual':
      nextPaymentDate =
          DateTime(startDate.year, startDate.month + 1, startDate.day);
      // Ajusta el día del mes si supera el número de días en el mes siguiente
      if (nextPaymentDate.month != startDate.month + 1) {
        nextPaymentDate = DateTime(nextPaymentDate.year, nextPaymentDate.month,
            0); // Último día del mes
      }
      break;
    default:
      throw ArgumentError(
          'Modo de pago no válido. Debe ser "semanal", "quincenal" o "mensual".');
  }

  return nextPaymentDate;
}

DateTime _startDate = DateTime.now();
DateTime _endDate = DateTime.now();

Future<void> selectDateRange(BuildContext context, final Function press) async {
  DateTimeRange? picked = await showDateRangePicker(
    context: context,
    firstDate: DateTime(2021),
    lastDate: DateTime(2100),
    initialDateRange: DateTimeRange(
      start: _startDate,
      end: _endDate,
    ),
  );

  if (picked != null) {
    _startDate = picked.start;
    _endDate = picked.end;
    press(_startDate.toString().substring(0, 10),
        _endDate.toString().substring(0, 10));
  }
}

Future<bool?> showConfirmationDialog(
    BuildContext context, String message, String concepto) {
  return showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        title: Text('Confirmación',
            style: Theme.of(context).textTheme.titleMedium),
        content: SizedBox(
          width: 250,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text(message), Text('Concepto : ${concepto}')],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Cancelar'),
            onPressed: () {
              Navigator.of(context).pop(false); // Devuelve falso si se cancela
            },
          ),
          TextButton(
            child: Text('Aceptar'),
            onPressed: () {
              Navigator.of(context).pop(true); // Devuelve true si se acepta
            },
          ),
        ],
      );
    },
  );
}

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {Key? key,
      required this.labelText,
      this.icon,
      this.onChanged,
      this.enabled = true,
      this.controller,
      this.obscureText = false,
      this.textInputType})
      : super(key: key);
  final String labelText;
  final IconData? icon;
  final ValueChanged<String>? onChanged;
  final bool? enabled;
  final TextEditingController? controller;
  final bool? obscureText;
  final TextInputType? textInputType;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: SizedBox(
        height: 45,
        child: TextFormField(
          obscureText: obscureText ?? false,
          controller: controller,
          enabled: enabled,
          onChanged: onChanged,
          keyboardType: textInputType ?? TextInputType.text,
          decoration: InputDecoration(
            labelText: labelText,
            labelStyle: TextStyle(color: Colors.black54),
            prefixIcon: icon != null ? Icon(icon, color: Colors.black54) : null,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0) // Borde circular
                ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                  color: Colors
                      .black54), // Color del borde cuando no está enfocado
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                    color: Colors.black54,
                    width: 1.0) // Color del borde cuando está enfocado
                ),
          ),
        ),
      ),
    );
  }
}
