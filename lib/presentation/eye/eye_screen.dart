import 'dart:convert';
import 'dart:io';

import 'package:eye_ia_detection/core/utils/utils.dart';
import 'package:eye_ia_detection/presentation/assistant/assistent_gpt.dart';
import 'package:eye_ia_detection/presentation/global_controller.dart';
import 'package:eye_ia_detection/presentation/ui/atoms/custom_button_widget.dart';
import 'package:eye_ia_detection/presentation/ui/atoms/dashed_border_container.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as Path;

import 'package:image/image.dart' as Img;
import 'package:get/get.dart';

class EyeScreen extends StatefulWidget {
  EyeScreen({super.key});

  @override
  State<EyeScreen> createState() => _EyeScreenState();
}

class _EyeScreenState extends State<EyeScreen> {
  GlobalController controller = Get.find();
  final picker = ImagePicker();

  Future<File?> getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    if (pickedFile != null) {
      return File(pickedFile.path);
    } else {
      print('No image selected.');
    }
    return null;
  }

  Future<String?> uploadImage(File? image) async {
    if (image != null) {
      // Comprimir la imagen antes de subirla
      File compressedImageFile = await compressImage(image!);

      // Subir el archivo comprimido a Firebase Storage
      String fileName = Path.basename(compressedImageFile.path);
      Reference storageReference =
          FirebaseStorage.instance.ref().child('images/$fileName');
      UploadTask uploadTask = storageReference.putFile(
          compressedImageFile,
          SettableMetadata(
            contentType: 'image/jpeg',
          ));
      await uploadTask.whenComplete(() => print('Image uploaded'));

      // Obtener la URL de descarga de la imagen
      String downloadURL = await storageReference.getDownloadURL();
      print('Download URL: $downloadURL');
      return downloadURL;
    } else {
      showToastMessage("no se encontro la imagen");
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
        title: Text('Recopilacion de fotos'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                "Para un mejor diagnostico, Por favor tome fotos como indica cada imagen,",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Center(
              child: btonEye(
                'assets/images/centro.png',
                textoGuia: "Ojo mirando\nal centro",
                image: controller.imageEyeCenter,
                ontap: () async {
                  print(' ----- ');
                  controller.imageEyeCenter = await getImage();

                  setState(() {});
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                btonEye(
                  'assets/images/izquierda.png',
                  textoGuia: "Ojo mirando\na la izquierda",
                  image: controller.imageEyeleft,
                  ontap: () async {
                    print(' ----- ');
                    await excecuteProcess(context, () async {
                      controller.imageEyeleft = await getImage();
                    });
                    setState(() {});
                  },
                ),
                btonEye(
                  'assets/images/derecha.png',
                  textoGuia: "Ojo mirando\na la derecha",
                  image: controller.imageEyeRigth,
                  ontap: () async {
                    print(' ----- ');
                    await excecuteProcess(context, () async {
                      controller.imageEyeRigth = await getImage();
                    });
                    setState(() {});
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                btonEye(
                  'assets/images/arriba.png',
                  textoGuia: "Ojo mirando\narriba",
                  image: controller.imageEyeUp,
                  ontap: () async {
                    print(' ----- ');
                    await excecuteProcess(context, () async {
                      controller.imageEyeUp = await getImage();
                    });
                    setState(() {});
                  },
                ),
                btonEye(
                  'assets/images/abajo.png',
                  textoGuia: "Ojo mirando\nabajo",
                  image: controller.imageEyeButtom,
                  ontap: () async {
                    print(' ----- ');
                    await excecuteProcess(context, () async {
                      controller.imageEyeButtom = await getImage();
                    });
                    setState(() {});
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: CustomButtonWidget(
                textButton: 'Procesar Imagenes',
                onTap: () async {
                  if (controller.imageEyeCenter == null ||
                      controller.imageEyeUp == null ||
                      controller.imageEyeButtom == null ||
                      controller.imageEyeleft == null ||
                      controller.imageEyeRigth == null) {
                    showToastMessage('Por favor complete las fotos');
                  } else {
                    // excecuteProcess(context, () async {
                    //   // controller.imageUrl1 =
                    //   //     await uploadImage(controller.imageEyeCenter);
                    //   if (controller.imageEyeCenter != null) {
                    //     final contents =
                    //         controller.imageEyeCenter!.readAsBytesSync();
                    //     final encondedContents = base64.encode(contents);
                    //     controller.prediction1 = await controller
                    //         .makePostRequestWithBase64(encondedContents);
                    //   }
                    //   if (controller.imageEyeUp != null) {
                    //     final contents =
                    //         controller.imageEyeUp!.readAsBytesSync();
                    //     final encondedContents = base64.encode(contents);
                    //     controller.prediction2 = await controller
                    //         .makePostRequestWithBase64(encondedContents);
                    //   }
                    //   // if (controller.imageEyeButtom != null) {
                    //   //   final contents =
                    //   //       controller.imageEyeButtom!.readAsBytesSync();
                    //   //   final encondedContents = base64.encode(contents);
                    //   //   controller.prediction3 = await controller
                    //   //       .makePostRequestWithBase64(encondedContents);
                    //   // }
                    //   // if (controller.imageEyeleft != null) {
                    //   //   final contents =
                    //   //       controller.imageEyeleft!.readAsBytesSync();
                    //   //   final encondedContents = base64.encode(contents);
                    //   //   controller.prediction4 = await controller
                    //   //       .makePostRequestWithBase64(encondedContents);
                    //   // }
                    //   // if (controller.imageEyeRigth != null) {
                    //   //   final contents =
                    //   //       controller.imageEyeRigth!.readAsBytesSync();
                    //   //   final encondedContents = base64.encode(contents);
                    //   //   controller.prediction5 = await controller
                    //   //       .makePostRequestWithBase64(encondedContents);
                    //   // }
                    //   print(controller);

                    // });

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AssistentGpt()));
                  }
                },
              ),
            )
          ],
        ),
      ),
      // body: Center(
      //   child: _image == null
      //       ? Text('No has tomado una foto aún.')
      //       : Image.file(_image!),
      // ),
      // floatingActionButton: Column(
      //   mainAxisAlignment: MainAxisAlignment.end,
      //   children: [
      //     FloatingActionButton(
      //       onPressed: getImage,
      //       tooltip: 'Tomar Foto',
      //       heroTag: 'asda',
      //       child: Icon(Icons.camera),
      //     ),
      //     SizedBox(height: 10),
      //     FloatingActionButton(
      //       onPressed: uploadImage,
      //       tooltip: 'Subir Imagen',
      //       child: Icon(Icons.cloud_upload),
      //     ),
      //   ],
      // ),
    );
  }

  Widget btonEye(String ruta,
      {Function? ontap, required String textoGuia, required File? image}) {
    print(image);
    if (image != null) {
      return Padding(
        padding: EdgeInsets.all(10),
        child: InkWell(
          onTap: () {
            ontap?.call();
          },
          child: DashedBorderContainer(
            borderRadius: BorderRadius.circular(20),
            child: Ink(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.transparent,
              ),
              width: 150,
              height: 150,
              padding: EdgeInsets.all(20),
              child: Center(
                child: Image.file(
                  image,
                  width: 150,
                  height: 150,
                ),
              ),
            ),
          ),
        ),
      );
    }
    return Padding(
      padding: EdgeInsets.all(10),
      child: Stack(
        alignment: Alignment.center,
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () async {
              ontap?.call();
            },
            child: DashedBorderContainer(
              borderRadius: BorderRadius.circular(20),
              child: Ink(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.transparent,
                ),
                width: 150,
                height: 150,
                padding: EdgeInsets.all(20),
                child: Center(
                  child: Image.asset(
                    ruta,
                    width: 150,
                    height: 150,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 10,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(textoGuia),
            ),
          ),
          Positioned(
            bottom: 10,
            child: Text(
              'Tomar foto',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
