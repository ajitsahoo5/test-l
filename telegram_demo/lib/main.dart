import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Telegram Bot',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TelegramBotScreen(),
    );
  }
}

class TelegramBotScreen extends StatefulWidget {
  @override
  _TelegramBotScreenState createState() => _TelegramBotScreenState();
}

class _TelegramBotScreenState extends State<TelegramBotScreen> {
  final TextEditingController _messageController = TextEditingController();
  final String botToken = '7459484846:AAGWuy1uU7d-dQGvOQVJv8OnZQtaoFsMzb8'; // Replace with your bot token
  // final String chatId = '6159405547'; // Replace with your chat ID
  final String chatId = '-4501779757';

  Future<void> sendMessage(String message) async {
    final url = 'https://api.telegram.org/bot$botToken/sendMessage';
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'chat_id': chatId,
        'text': message,
      }),
    );

    if (response.statusCode == 200) {
      print('Message sent successfully');
    } else {
      print('Failed to send message: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Send Telegram Message'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _messageController,
              decoration: InputDecoration(labelText: 'Message'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final message = _messageController.text;
                if (message.isNotEmpty) {
                  sendMessage(message);
                  _messageController.clear();
                }
              },
              child: Text('Send Message'),
            ),
          ],
        ),
      ),
    );
  }
}
