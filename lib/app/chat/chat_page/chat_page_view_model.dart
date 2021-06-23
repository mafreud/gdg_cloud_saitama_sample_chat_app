import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../chat_service.dart';
import 'package:uuid/uuid.dart';

import '../../../constants.dart';
import '../chat_model.dart';

final chatPageViewModelProvider =
    ChangeNotifierProvider<ChatPageViewModel>((ref) {
  return ChatPageViewModel(
    ref.watch(chatServiceProvider),
  );
});

class ChatPageViewModel extends ChangeNotifier {
  ChatPageViewModel(this._chatService);
  final ChatService _chatService;
  final textEditingController = TextEditingController();

  Future<void> setChatData(String senderId) async {
    final uuid = const Uuid();
    final chatId = uuid.v4();
    final text = textEditingController.text;
    final chat = ChatModel(
        chatId, senderId, text, Constants.sampleChatRoomId, DateTime.now());
    await _chatService.setChatData(chat);
    textEditingController.clear();
  }

  Stream<List<ChatModel>> chatListStream(String chatRoomId) {
    return _chatService.chatListStream(chatRoomId);
  }
}
