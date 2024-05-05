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

  void initChat() async {
    waitingResponse.value = true;
    final response = await chatGPT.sendMessage('''
Quier que hables como un Asistente virtual de una applicacion mobile potenciada con inteligencia artificial llamada "EyeAi" la idea de este chat es que te mandare un parrafo que describe si tengo algun malestar, y acontinuacion te mandare un conjunto de Jsons donde esta informacion sobre el analizis de mis ojos que fueron tomadas por una camara y un modelo entrenado para detectar 
- Ojos saltones
- Cataratas
- Ojos cruzados
- Glaucoma
- uveítis

donde tiene cada json 2 clases "confidence, class", donde confidence es la probabilidad del diagnostico y class es la clase del diagnostico.

El conjunto de json es el siguiente

${controller.getAllJsonsInformacion()}

por favor empieza con un "Hola soy el asistente inteligente de "EyeAi", despues de procesar la informacion que nos diste tengo el siguiente pre-diagnostico para ti"
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
      listOfProductsSuggest.value = getProfessionalModelSuggested(response);
      addWidgetMessage('gpt', response);
    }
  }

  List<ProfessionalModel> getProfessionalModelSuggested(String response) {
    List<ProfessionalModel> listToReturn = [];
    listToReturn = listOfProductsSuggest
        .where((element) => response
            .toLowerCase()
            .contains((element.nombre ?? '_').toLowerCase()))
        .toList();

    return listToReturn;
  }
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
