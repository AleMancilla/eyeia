// To parse this JSON data, do
//
//     final response = responseFromJson(jsonString);

import 'dart:convert';

ModelAiEyeDisease responseFromJson(String str) =>
    ModelAiEyeDisease.fromJson(json.decode(str));

String responseToJson(ModelAiEyeDisease data) => json.encode(data.toJson());

class ModelAiEyeDisease {
  double? time;
  Image? image;
  List<Prediction>? predictions;

  ModelAiEyeDisease({
    this.time,
    this.image,
    this.predictions,
  });

  factory ModelAiEyeDisease.fromJson(Map<String, dynamic> json) =>
      ModelAiEyeDisease(
        time: json["time"]?.toDouble(),
        image: json["image"] == null ? null : Image.fromJson(json["image"]),
        predictions: json["predictions"] == null
            ? []
            : List<Prediction>.from(
                json["predictions"]!.map((x) => Prediction.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "time": time,
        "image": image?.toJson(),
        "predictions": predictions == null
            ? []
            : List<dynamic>.from(predictions!.map((x) => x.toJson())),
      };
}

class Image {
  int? width;
  int? height;

  Image({
    this.width,
    this.height,
  });

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        width: json["width"],
        height: json["height"],
      );

  Map<String, dynamic> toJson() => {
        "width": width,
        "height": height,
      };
}

class Prediction {
  double? x;
  double? y;
  double? width;
  double? height;
  double? confidence;
  String? predictionClass;
  int? classId;
  String? detectionId;

  Prediction({
    this.x,
    this.y,
    this.width,
    this.height,
    this.confidence,
    this.predictionClass,
    this.classId,
    this.detectionId,
  });

  factory Prediction.fromJson(Map<String, dynamic> json) => Prediction(
        x: json["x"]?.toDouble(),
        y: json["y"]?.toDouble(),
        width: json["width"]?.toDouble(),
        height: json["height"]?.toDouble(),
        confidence: json["confidence"]?.toDouble(),
        predictionClass: json["class"],
        classId: json["class_id"],
        detectionId: json["detection_id"],
      );

  Map<String, dynamic> toJson() => {
        "x": x,
        "y": y,
        "width": width,
        "height": height,
        "confidence": confidence,
        "class": predictionClass,
        "class_id": classId,
        "detection_id": detectionId,
      };

  Map<String, dynamic> toJsonForChatGPT() => {
        "probabilidad": confidence,
        "clase": predictionClass,
      };
}
