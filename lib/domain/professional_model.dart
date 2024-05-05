// To parse this JSON data, do
//
//     final professionalModel = professionalModelFromJson(jsonString);

import 'dart:convert';

List<ProfessionalModel> professionalModelFromJson(String str) =>
    List<ProfessionalModel>.from(
        json.decode(str).map((x) => ProfessionalModel.fromJson(x)));

String professionalModelToJson(List<ProfessionalModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProfessionalModel {
  String? imagen;
  String? nombre;
  String? especializacion;
  String? direccion;
  String? descripcion;

  ProfessionalModel({
    this.imagen,
    this.nombre,
    this.especializacion,
    this.direccion,
    this.descripcion,
  });

  factory ProfessionalModel.fromJson(Map<String, dynamic> json) =>
      ProfessionalModel(
        imagen: json["imagen"],
        nombre: json["nombre"],
        especializacion: json["especializacion"],
        direccion: json["direccion"],
        descripcion: json["descripcion"],
      );

  Map<String, dynamic> toJson() => {
        "imagen": imagen,
        "nombre": nombre,
        "especializacion": especializacion,
        "direccion": direccion,
        "descripcion": descripcion,
      };
}
