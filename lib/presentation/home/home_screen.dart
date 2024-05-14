import 'package:eye_ia_detection/core/theme/custom_colors.dart';
import 'package:eye_ia_detection/presentation/consultation/consultation_screen.dart';
import 'package:eye_ia_detection/presentation/global_controller.dart';
import 'package:eye_ia_detection/presentation/ui/atoms/custom_button_widget.dart';
import 'package:eye_ia_detection/presentation/ui/atoms/custom_drop_down.dart';
import 'package:eye_ia_detection/presentation/ui/atoms/custom_text_file.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalController controller = Get.put(GlobalController());

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
                controller: controller.nameController,
                hintText: "Nombre",
                labelText: "Nombre",
              ),
              SizedBox(height: 20),
              CustomTextFile(
                controller: controller.ageController,
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
                    controller.cityController.text = (value ?? '_');
                    setState(() {});
                  }),
              SizedBox(height: 20),
              CustomDropdown(
                  items: [
                    "HOMBRE",
                    "MUJER",
                    "OTRO",
                  ],
                  hintText: 'Seleccione una opcion',
                  selectedItem: getDropDownValueSex(),
                  borderColor: CustomColors.primary,
                  onChanged: (value) {
                    controller.sexController.text = (value ?? '_');
                    setState(() {});
                  }),
              SizedBox(height: 20),
              CustomTextFile(
                controller: controller.sexController,
                hintText: 'Sexo',
                labelText: 'Sexo',
              ),
              SizedBox(height: 20),
              CustomTextFile(
                controller: controller.municipalityController,
                hintText: 'Municipio',
                labelText: 'Municipio',
              ),
              SizedBox(height: 20),
              CustomButtonWidget(
                textButton: 'Continuar',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ConsultationScreen()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  String? getDropDownValue() {
    if (controller.cityController.text == '') {
      return null;
    }
    return controller.cityController.text;
  }

  String? getDropDownValueSex() {
    if (controller.sexController.text == '') {
      return null;
    }
    return controller.sexController.text;
  }
}
