import 'package:eye_ia_detection/core/theme/custom_colors.dart';
import 'package:eye_ia_detection/presentation/ui/atoms/custom_button_widget.dart';
import 'package:eye_ia_detection/presentation/ui/atoms/custom_drop_down.dart';
import 'package:eye_ia_detection/presentation/ui/atoms/custom_text_file.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _sexController = TextEditingController();
  final TextEditingController _municipalityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Datos del Usuario'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Por favor ayudanos a conocerte mejor",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
              CustomTextFile(
                controller: _nameController,
                hintText: "Nombre",
                labelText: "Nombre",
              ),
              SizedBox(height: 20),
              CustomTextFile(
                controller: _ageController,
                hintText: 'Edad',
                labelText: 'Edad',
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20),
              CustomDropdown(
                  items: [
                    "LA PAZ",
                    "COCHABAMBA",
                    "SANTA CRUZ",
                    "ORURO",
                    "CHUQUISACA",
                    "POTOSÍ",
                    "TARIJA",
                    "BENI",
                    "PANDO"
                  ],
                  hintText: 'Seleccione una ciudad',
                  selectedItem: getDropDownValue(),
                  borderColor: CustomColors.primary,
                  onChanged: (value) {
                    _cityController.text = (value ?? '_');
                    setState(() {});
                  }),
              SizedBox(height: 20),
              CustomTextFile(
                controller: _sexController,
                hintText: 'Sexo',
                labelText: 'Sexo',
              ),
              SizedBox(height: 20),
              CustomTextFile(
                controller: _municipalityController,
                hintText: 'Municipio',
                labelText: 'Municipio',
              ),
              SizedBox(height: 20),
              CustomButtonWidget(
                textButton: 'Continuar',
                onTap: () {
                  // controller.submitAppointment();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  String? getDropDownValue() {
    if (_cityController.text == '') {
      return null;
    }
    return _cityController.text;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _cityController.dispose();
    _sexController.dispose();
    _municipalityController.dispose();
    super.dispose();
  }
}
