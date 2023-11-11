import 'package:chat_gpt/features/presentation/views/widgets/chat_body_screen.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text(
          'Ask AI',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 25, color:Colors.white),
        ),
        centerTitle: true,
      ),
      body: const ChatBody(),
    );
  }
}
