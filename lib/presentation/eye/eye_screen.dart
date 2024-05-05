import 'dart:io';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as Path;

import 'package:image/image.dart' as Img;

class EyeScreen extends StatefulWidget {
  EyeScreen({super.key});

  @override
  State<EyeScreen> createState() => _EyeScreenState();
}

class _EyeScreenState extends State<EyeScreen> {
  File? _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future uploadImage() async {
    if (_image != null) {
      // Comprimir la imagen antes de subirla
      File compressedImageFile = await compressImage(_image!);

      // Subir el archivo comprimido a Firebase Storage
      String fileName = Path.basename(compressedImageFile.path);
      Reference storageReference =
          FirebaseStorage.instance.ref().child('images/$fileName');
      UploadTask uploadTask = storageReference.putFile(compressedImageFile);
      await uploadTask.whenComplete(() => print('Image uploaded'));

      // Obtener la URL de descarga de la imagen
      String downloadURL = await storageReference.getDownloadURL();
      print('Download URL: $downloadURL');
    }
  }

  Future<File> compressImage(File imageFile) async {
    // Decodificar la imagen utilizando la biblioteca image
    Img.Image image = Img.decodeImage(imageFile.readAsBytesSync())!;

    // Redimensionar la imagen a un tamaño específico (opcional)
    image = Img.copyResize(image, width: 800);

    // Crear un archivo temporal para la imagen comprimida
    File compressedImageFile = File('${imageFile.path}.compressed.jpg');

    // Codificar la imagen en formato JPEG con una calidad del 80% y guardarla en el archivo temporal
    compressedImageFile.writeAsBytesSync(Img.encodeJpg(image, quality: 80));

    return compressedImageFile;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tomar Foto y Subir a Firebase Storage'),
      ),
      body: Center(
        child: _image == null
            ? Text('No has tomado una foto aún.')
            : Image.file(_image!),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: getImage,
            tooltip: 'Tomar Foto',
            child: Icon(Icons.camera),
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            onPressed: uploadImage,
            tooltip: 'Subir Imagen',
            child: Icon(Icons.cloud_upload),
          ),
        ],
      ),
    );
  }
}
