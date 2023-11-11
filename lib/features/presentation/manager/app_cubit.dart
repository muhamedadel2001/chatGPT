import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:chat_gpt/constants.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());
  static AppCubit get(context) => BlocProvider.of<AppCubit>(context);
  final ChatUser currUser = ChatUser(id: '1', firstName: 'muhamed');
  final ChatUser chatGpt = ChatUser(id: '2', firstName: 'ChatGPT3');
  List<ChatMessage> message = <ChatMessage>[];
  List<ChatUser> typingUser = <ChatUser>[];
  final openAi = OpenAI.instance.build(
    token: chatGptApiKey,
    baseOption: HttpSetup(receiveTimeout: const Duration(seconds: 60)),
    enableLog: true,
  );

  Future<void> sendMessage(ChatMessage m) async {
    message.insert(0, m);
    emit(AppSendMessage());
    emit(AppLoadingResponse());
    typingUser.add(chatGpt);
    List<Messages> messagesHistory = message.reversed.map((m) {
      if (m.user == currUser) {
        return Messages(role: Role.user, content: m.text);
      } else {
        return Messages(role: Role.assistant, content: m.text);
      }
    }).toList();
    final request = ChatCompleteText(
        model: GptTurbo0301ChatModel(),
        messages: messagesHistory,
        maxToken: 200);
    final response = await openAi.onChatCompletion(request: request);
    for (var element in response!.choices) {
      if (element.message != null) {
        emit(AppSuccessResponse());
        typingUser.remove(chatGpt);
        message.insert(
            0,
            ChatMessage(
                user: chatGpt,
                createdAt: DateTime.now(),
                text: element.message!.content));
      }
    }
  }
}
