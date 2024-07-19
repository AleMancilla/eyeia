import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

class ChatGPT {
  final String apiKey;

  ChatGPT(this.apiKey);

  final List<Map<String, String>> messages = [];
  Future<String> sendMessage(String prompt) async {
    messages.add({
      'role': 'user',
      'content': prompt,
    });
    try {
      final res = await http.post(
        Uri.parse('https://api.openai.com/v1/chat/completions'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey',
        },
        body: jsonEncode({
          "model": "gpt-3.5-turbo",
          "messages": messages,
        }),
      );

      String decodedText = utf8.decode(res.bodyBytes);

      var jsonObject = jsonDecode(decodedText);

      log(decodedText);
      if (res.statusCode == 200) {
        String content = jsonObject['choices'][0]['message']['content'];
        content = content.trim();

        messages.add({
          'role': 'assistant',
          'content': content,
        });
        return content;
      }
      return 'An internal error occurred';
    } catch (e) {
      return e.toString();
    }
  }
}


// actúa como un representante de la ortopedia boliviana Alemana, te hablare como un paciente con problemas y no se que producto es mejor para mis malestares, quiero que me des sugerencias de productos en nombre de la Ortopedia Boliviana Alemana