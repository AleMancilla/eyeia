import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GlobalController extends GetxController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController sexController = TextEditingController();
  final TextEditingController municipalityController = TextEditingController();
  final TextEditingController descriptionOfSintom = TextEditingController();
  File? imageEyeCenter;
  File? imageEyeUp;
  File? imageEyeButtom;
  File? imageEyeleft;
  File? imageEyeRigth;

  String? imageUrl1;
  String? imageUrl2;
  String? imageUrl3;
  String? imageUrl4;
  String? imageUrl5;

  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();
    cityController.dispose();
    sexController.dispose();
    municipalityController.dispose();
    super.dispose();
  }
}
