import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GlobalController extends GetxController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController sexController = TextEditingController();
  final TextEditingController municipalityController = TextEditingController();
  final TextEditingController descriptionOfSintom = TextEditingController();

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
