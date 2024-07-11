import 'dart:convert';
import 'package:http/http.dart' as http;

class OpenAIService {
  final String apiKey;

  OpenAIService(this.apiKey);

  Future<String> sendMessage(String message) async {
    final url = Uri.parse('https://api.openai.com/v1/chat/completions');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey',
        },
        body: jsonEncode({
          'model': 'gpt-3.5-turbo',
          'messages': [
            {'role': 'user', 'content': message},
          ],
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['choices'][0]['message']['content'].trim();
      } else {
        // Log the response for debugging
        print('Failed to connect to OpenAI API: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to connect to OpenAI API');
      }
    } catch (e) {
      // Log the error for debugging
      print('Error connecting to OpenAI API: $e');
      throw Exception('Failed to connect to OpenAI API');
    }
  }
}
