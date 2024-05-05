import 'package:eye_ia_detection/core/theme/custom_colors.dart';
import 'package:eye_ia_detection/presentation/assistant/controller/support_gpt_controller.dart';
import 'package:eye_ia_detection/presentation/ui/molecules/custom_load_widget.dart';
import 'package:eye_ia_detection/presentation/ui/organisms/item_product_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';

class AssistentGpt extends StatefulWidget {
  AssistentGpt({super.key});

  @override
  State<AssistentGpt> createState() => _SupportGptScreenState();
}

class _SupportGptScreenState extends State<AssistentGpt> {
  TextEditingController controllerSearch = TextEditingController();

  bool isFocused = false;

  String textSearching = '';

  SupportGptController gptController = Get.put(SupportGptController());

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size sizeScreen = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('EyeAi Assistant'),
      ),
      backgroundColor: Color.fromRGBO(242, 242, 249, 1),
      body: Obx(() => Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    for (final ModelMessageToGpt line
                        in gptController.listMessageToShow)
                      itemMessage(line),
                  ],
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Obx(() => Row(
                      children: [
                        SizedBox(width: 30),
                        ...gptController.listOfProductsSuggest
                            .map((product) => ItemProduct(
                                  isMinimunVersion: true,
                                  imageUrl: product.imagen,
                                  name: product.nombre ?? '_',
                                  ontap: () {
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute<void>(
                                    //     builder: (BuildContext context) =>
                                    //         ProductScreen(
                                    //       product: product,
                                    //     ),
                                    //   ),
                                    // );
                                  },
                                ))
                            .toList(),
                      ],
                    )),
              ),
              // CustomLoadingWidget(),
              if (gptController.waitingResponse.value) CustomLoadingWidget(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: 'Escribe una pregunta aqui si la tienes...',
                    suffixIcon: IconButton(
                      icon: Icon(Icons.send),
                      onPressed: () async {
                        String dataToSend = _controller.text.trim();
                        _controller.clear();
                        await gptController.sendMessage(dataToSend);
                      },
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }

  Container itemMessage(ModelMessageToGpt line) {
    if (line.rol == 'gpt') {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: CustomColors.greyGreenSimple,
        ),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        margin: EdgeInsets.only(right: 60, left: 20, top: 10, bottom: 10),
        child: Text(line.message),
      );
    }
    if (line.rol == 'user') {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: CustomColors.greyGreenSimple,
        ),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        margin: EdgeInsets.only(right: 20, left: 60, top: 10, bottom: 10),
        child: Text(line.message),
      );
    }
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: CustomColors.greyGreenSimple,
      ),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Text(line.message),
    );
  }
}
