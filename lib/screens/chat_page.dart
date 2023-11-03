import 'dart:convert';
import 'dart:io';
import 'package:farm_financer/screens/tts/speech.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<types.Message> _messages = [];
  final _questionController = TextEditingController();
  String _response = '';
  final _user = const types.User(
    id: '82091008-a484-4a89-ae75-a22bf8d6f3ac',
  );
  final _user2 = const types.User(
    id: '82091008-a484-4a89-ae75-a22bf8d6f3ad',
  );

  Future<void> _askQuestion(String question) async {
    final response = await http.post(
      Uri.parse('http://192.168.45.9:5000/chatbot'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'question': question}),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print(data['response']);
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
  void initState() {
    super.initState();
    // _loadMessages();
  }

  void _addMessage(types.Message message) {
    setState(() {
      _messages.insert(0, message);
    });
  }


  void _handleSendPressed(types.PartialText message) async{
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: message.text,
    );

    _addMessage(textMessage);
    await _askQuestion(message.text);
    final textMessage2 = types.TextMessage(
      author: _user2,

      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: _response,
    );
    _addMessage(textMessage2);
  }



  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
      backgroundColor: Colors.deepOrangeAccent,

        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.mic),
            onPressed: (){
              var tts = TTSController();
              tts.speakText(_response);
            },
          ),
        ],

        title: Text("Financer Bot"),
      ),
        body: Chat(
          theme: DefaultChatTheme(
            backgroundColor: Colors.black
          ),
          messages: _messages,
          onSendPressed: _handleSendPressed,
          showUserAvatars: true,
          showUserNames: true,
          user: _user,
        ),

      ),
    ),
  );
}