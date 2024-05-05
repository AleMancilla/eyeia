import 'package:eye_ia_detection/presentation/global_controller.dart';
import 'package:eye_ia_detection/presentation/ui/atoms/custom_button_widget.dart';
import 'package:eye_ia_detection/presentation/ui/atoms/custom_text_file.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ConsultationScreen extends StatelessWidget {
  ConsultationScreen({super.key});

  GlobalController controller = Get.find();
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
                "Para un mejor diagnostico porfavor indicanos si tuviste algun malestar o dolencia en los ojos.",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
              CustomTextFile(
                controller: controller.descriptionOfSintom,
                labelText: "Descripcion",
                hintText:
                    "Describe el malestar que tuviste lo mas detallado posible",
                maxLines: 5,
              ),
              SizedBox(height: 30),
              CustomButtonWidget(
                textButton: 'Continuar',
                onTap: () {
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => HomeScreen()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
