import 'package:farm_financer/widgets/chatBox.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:velocity_x/velocity_x.dart';
class ChatBot extends StatefulWidget {
  @override
  _ChatBotState createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {
  String _response = '';
  String _chatQn = '';
  final _questionController = TextEditingController();

  Future<void> _askQuestion(String question) async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:5000/chatbot'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'question': question}),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        _response = data['response'] ?? 'No response from server';
      });
    } else {
      setState(() {
        _response = 'Failed to get response';
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.only(bottom: 150,left: 16,right: 16),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(_response),


              TextField(
                controller: _questionController,
                decoration: InputDecoration(
                  labelText: 'Enter your question',
                  border: OutlineInputBorder(),
                  labelStyle: TextStyle(color: Colors.white54),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () {
                      _askQuestion(_questionController.text);
                      setState(() {
                        _chatQn=_questionController.text;
                      });


                    },
                  ),
                  suffixIconColor: Colors.white54



                ),
              ),




            ],
          ),
        ),
      ),
    );
  }
}
