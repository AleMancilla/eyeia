import 'package:eye_ia_detection/core/utils/chat_gpt.dart';
import 'package:eye_ia_detection/domain/professional_model.dart';
import 'package:eye_ia_detection/presentation/global_controller.dart';
import 'package:get/get.dart';

class SupportGptController extends GetxController {
  RxList<ModelMessageToGpt> listMessageToShow = <ModelMessageToGpt>[].obs;
  GlobalController controller = Get.find();
  // RxList<Product> listOfProductsSuggest = <Product>[].obs;
  RxBool waitingResponse = false.obs;
  final ChatGPT chatGPT =
      ChatGPT('sk-proj-W26R8NoS7vS3kk5un1JnT3BlbkFJiCsgNVL94YhmfKENWSXV');

  String _response = '';

  RxList<ProfessionalModel> listOfProductsSuggest = <ProfessionalModel>[].obs;
  @override
  void onInit() {
    initChat();
    super.onInit();
  }

  List<ProfessionalModel> chargeDataSuggest() {
    return professionalModelFromJson(""" [
      {
        "imagen": "https://media.licdn.com/dms/image/D4D03AQHM1JKqDMmKQQ/profile-displayphoto-shrink_800_800/0/1678731029091?e=2147483647&v=beta&t=1xwRDfSnfN_AclKge5Rzh6ctQIwZc0qRA0xeEs18LeA",
        "nombre": "Dr. Juan Pérez",
        "especializacion": "Oftalmología",
        "direccion": "Calle Principal #123, Ciudad Principal",
        "descripcion":
            "El Dr. Juan Pérez es un reconocido oftalmólogo con más de 15 años de experiencia en el campo. Se especializa en el tratamiento de enfermedades oculares, cirugía de cataratas y corrección de la visión con láser.",
        "cel":"59165537461"
      },
      {
        "imagen": "https://directoriomedicodeelsalvador.com/images/tn_dr-mauricio-arenivar-internista-san-salvador-perfil-440x500px.webp",
        "nombre": "Dra. María Gómez",
        "especializacion": "Oftalmología Pediátrica",
        "direccion": "Avenida Central #456, Ciudad Central",
        "descripcion":
            "La Dra. María Gómez es una especialista en oftalmología pediátrica dedicada a brindar atención médica a niños con problemas de visión. Su enfoque se centra en el diagnóstico temprano y el tratamiento de trastornos oculares en la infancia.",
        "cel":"59165537461"
      },
      {
        "imagen": "https://www.clinicaojoslaplata.com.ar/images/team-img4.jpg",
        "nombre": "Dr. Carlos Rodríguez",
        "especializacion": "Cirugía Refractiva",
        "direccion": "Plaza Principal #789, Ciudad Principal",
        "descripcion":
            "El Dr. Carlos Rodríguez es un experto en cirugía refractiva y corrección de la visión con láser. Ha realizado numerosos procedimientos exitosos para ayudar a pacientes a deshacerse de sus anteojos o lentes de contacto y mejorar su calidad de vida.",
        "cel":"59165537461"
      },
      {
        "imagen": "https://www.pasteur.cl/wp-content/uploads/2019/03/dr-hernan-gonzalez-2019-thegem-person.jpg",
        "nombre": "Dra. Laura Martínez",
        "especializacion": "Oftalmología Pediátrica",
        "direccion": "Calle Secundaria #321, Ciudad Secundaria",
        "descripcion":
            "La Dra. Laura Martínez es una experta en oftalmología pediátrica con una sólida formación en el diagnóstico y tratamiento de problemas de visión en niños y adolescentes. Su enfoque centrado en el paciente y su empatía la convierten en una elección popular entre las familias.",
        "cel":"59165537461"
      },
      {
        "imagen": "https://www.pasteur.cl/wp-content/uploads/2017/06/dr-kenneth-johnson-2019-thegem-person.jpg",
        "nombre": "Dr. Javier López",
        "especializacion": "Cirugía de Retina",
        "direccion": "Avenida Principal #567, Ciudad Principal",
        "descripcion":
            "El Dr. Javier López es un especialista en cirugía de retina altamente capacitado que ha realizado numerosas cirugías exitosas para tratar enfermedades de la retina como la retinopatía diabética y el desprendimiento de retina. Su dedicación a la excelencia y su atención personalizada a cada paciente lo distinguen en su campo.",
        "cel":"59165537461"
      }
    ]""");
  }

  void initChat() async {
    waitingResponse.value = true;
    final response = await chatGPT.sendMessage('''
Quier que hables como un Asistente virtual de una applicacion mobile potenciada con inteligencia artificial llamada "EyeAi" la idea de este chat es que te mandare un parrafo que describe si tengo algun malestar, y acontinuacion te mandare un conjunto de Jsons donde esta informacion sobre el analizis de mis ojos que fueron tomadas por una camara y un modelo entrenado para detectar 
- Ojos saltones
- Cataratas
- Ojos cruzados
- Glaucoma
- uveítis

donde tiene cada json 2 clases "probabilidad, clase", 

El conjunto de json es el siguiente

${controller.getAllJsonsInformacion()}

por favor saca un promedio de los datos ya que fueron 5 fotos diferentes del mismo ojo en distintos angulos

por favor empieza con un "Hola soy el asistente inteligente de "EyeAi", despues de procesar la informacion que nos diste tengo el siguiente pre-diagnostico para ti"

Dame la informacion de manera entendible a un usuario y quiza recomendaciones, no es necesario que me muestres la informacion de las 5 enfermedades, si no de la o las que creas que es mas importante tratar
''');
    _response = _response + "/NEWLINE/" + response;
    waitingResponse.value = false;
    addWidgetMessage('gpt', response);
  }

  void addWidgetMessage(String rol, String message) {
    listMessageToShow.add(ModelMessageToGpt(
      message: message,
      rol: rol,
      date: DateTime.now().millisecond,
    ));
  }

  Future<void> sendMessage(String message) async {
    addWidgetMessage('user', message);
    waitingResponse.value = true;
    if (message.isNotEmpty) {
      final response = await chatGPT.sendMessage(message);
      waitingResponse.value = false;
      _response = _response + "/NEWLINE/" + response;
      // listOfProductsSuggest.value = getProfessionalModelSuggested(response);
      addWidgetMessage('gpt', response);
    }
  }

  // List<ProfessionalModel> getProfessionalModelSuggested(String response) {
  //   List<ProfessionalModel> listToReturn = [];
  //   listToReturn = listOfProductsSuggest
  //       .where((element) => response
  //           .toLowerCase()
  //           .contains((element.nombre ?? '_').toLowerCase()))
  //       .toList();

  //   return listToReturn;
  // }
}

class ModelMessageToGpt {
  String message;
  String rol;
  int date;
  ModelMessageToGpt({
    required this.message,
    required this.rol,
    required this.date,
  });
}
