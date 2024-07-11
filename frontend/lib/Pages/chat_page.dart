import 'package:flutter/material.dart';
import 'package:maqderah/models/messages_model.dart';
import 'package:maqderah/openai_service.dart';

class chatPage extends StatefulWidget {
  @override
  _chatPageState createState() => _chatPageState();
}

class _chatPageState extends State<chatPage> {
  final TextEditingController _controller = TextEditingController();
  List<Message> _messages = [];
  late OpenAIService _openAIService;

  @override
  void initState() {
    super.initState();
    // Replace 'YOUR_API_KEY' with your actual API key
    _openAIService = OpenAIService(
        "");
  }

  Future<void> _sendMessage() async {
    final messageContent = _controller.text;
    if (messageContent.isNotEmpty) {
      setState(() {
        _messages.add(Message(content: messageContent, isUser: true));
      });
      _controller.clear();

      final response = await _openAIService.sendMessage(messageContent);
      setState(() {
        _messages.add(Message(content: response, isUser: false));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFF2D514B),
        title: Text(
          'Ask Maqderah',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return Container(
                  alignment: message.isUser
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  child: Container(
                    decoration: BoxDecoration(
                      color: message.isUser
                          ? Color(0xFFA0C7C1)
                          : Color(0xFF558981),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.all(12),
                    child: Text(
                      message.content,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      labelText: 'Enter your message',
                      labelStyle: TextStyle(color: Color(0xFF2D514B)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xFF2D514B), width: 2.0),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xFF2D514B), width: 1.0),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF2D514B),
                  ),
                  onPressed: _sendMessage,
                  child: Text(
                    'Send',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
