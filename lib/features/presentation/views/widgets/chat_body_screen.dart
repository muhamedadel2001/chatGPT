import 'package:chat_gpt/features/presentation/manager/app_cubit.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatBody extends StatefulWidget {
  const ChatBody({super.key});

  @override
  State<ChatBody> createState() => _ChatBodyState();
}

class _ChatBodyState extends State<ChatBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return DashChat(
          typingUsers: AppCubit.get(context).typingUser,
          currentUser: AppCubit.get(context).currUser,
          onSend: (ChatMessage m) {
            AppCubit.get(context).sendMessage(m);
          },
          messages: AppCubit.get(context).message,
          messageOptions: const MessageOptions(
              currentUserContainerColor: Colors.black,
              containerColor: Colors.teal),
        );
      },
    ));
  }
}
