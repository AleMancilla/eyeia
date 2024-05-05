import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

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

  Future<void> makePostRequestWithBase64(String base64Contents) async {
    const String apiUrl =
        'https://detect.roboflow.com/eye_diseases_detect/1?api_key=eQyFmgr5R9fwiS2vt4uv';
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: base64Contents,
    );
    print(response);
    print('==');
    print(response.body);
    if (response.statusCode == 200) {
      // Si la solicitud es exitosa (código de estado 201),
      // Imprimir la respuesta en la consola.
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
    } else {
      // Si la solicitud falla, imprimir el mensaje de error.
      throw Exception('Failed to load data');
    }
  }

  Future<void> makePostRequest(String imageUrl) async {
    final String apiUrl =
        'https://detect.roboflow.com/eye_diseases_detect/1?api_key=eQyFmgr5R9fwiS2vt4uv&image=$imageUrl';
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        // 'api_key': 'eQyFmgr5R9fwiS2vt4uv',
        // 'image': imageUrl
      },
    );
    print(response);

    if (response.statusCode == 201) {
      // Si la solicitud es exitosa (código de estado 201),
      // Imprimir la respuesta en la consola.
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
    } else {
      // Si la solicitud falla, imprimir el mensaje de error.
      throw Exception('Failed to load data');
    }
  }
}
