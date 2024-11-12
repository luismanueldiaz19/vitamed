import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/provider_doctor.dart';

class AddDoctorRegister extends StatefulWidget {
  const AddDoctorRegister({super.key});

  @override
  State<AddDoctorRegister> createState() => _AddDoctorRegisterState();
}

class _AddDoctorRegisterState extends State<AddDoctorRegister> {
  final _formKey = GlobalKey<FormState>();

  // Controladores para los campos de entrada
  final TextEditingController consultorioController = TextEditingController();
  final TextEditingController centroController = TextEditingController();
  final TextEditingController codigoController = TextEditingController();
  final TextEditingController especialidadController = TextEditingController();
  final TextEditingController horariosController = TextEditingController();
  final TextEditingController imageProfileController = TextEditingController();
  final TextEditingController informacionController = TextEditingController();
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController segurosController = TextEditingController();
  final TextEditingController starController = TextEditingController();
  final TextEditingController telefonoController = TextEditingController();
  final TextEditingController exequarteController = TextEditingController();
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Doctor"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildTextField("Nombre", nombreController),
              _buildTextField("Consultorio", consultorioController),
              _buildTextField("Centro", centroController),
              _buildTextField("Exequatur", exequarteController),
              _buildTextField("Especialidad", especialidadController),
              _buildTextField("Horarios", horariosController),
              // _buildTextField("Imagen de Perfil URL", imageProfileController),
              _buildTextField("Información", informacionController),

              _buildTextField(
                  "Seguros (separados por comas)", segurosController),
              // _buildTextField("Estrellas", starController),
              _buildTextField("Teléfono", telefonoController),

              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text("Guardar Doctor"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Este campo es obligatorio';
          }
          return null;
        },
      ),
    );
  }

  void _submitForm() async {
    String imageUrl =
        'https://st.depositphotos.com/1011643/1490/i/450/depositphotos_14901429-stock-photo-group-of-medical-workers-working.jpg';
    if (_formKey.currentState?.validate() ?? false) {
      // Convertir los datos en un JSON o Map
      final doctorData = {
        "nombre": nombreController.text,
        "consultorio": consultorioController.text,
        "centro": centroController.text,
        "exequarter": exequarteController.text,
        "especialidad": especialidadController.text,
        "horarios": horariosController.text,
        "image_profile": imageUrl,
        "informacion": informacionController.text,
        "is_favorite": isFavorite,
        "seguros":
            segurosController.text.split(',').map((e) => e.trim()).toList(),
        "star": 2.3,
        "telefono": telefonoController.text
      };
      await Provider.of<ProviderDoctor>(context, listen: false)
          .addDoctor(doctorData);

      print(
          doctorData); // Aquí podrías enviar los datos a una API o base de datos

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Doctor añadido exitosamente')),
      );

      // Aquí puedes limpiar el formulario si es necesario
      _formKey.currentState?.reset();
    }
  }
}
