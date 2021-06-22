import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gdg_cloud_saitama_sample_chat_app/app/chat/chat_model.dart';
import 'package:gdg_cloud_saitama_sample_chat_app/app/chat/chat_remote_data_source.dart';
import 'package:gdg_cloud_saitama_sample_chat_app/app/chat/chat_repository.dart';
import 'package:gdg_cloud_saitama_sample_chat_app/cloud_firestore/cloud_firestore_service.dart';
import 'package:gdg_cloud_saitama_sample_chat_app/cloud_firestore/firestore_path.dart';

final chatServiceProvider = Provider<ChatService>((ref) {
  return ChatService(ref.watch(chatRepositoryProvider));
});

class ChatService {
  ChatService(this._chatRepository);

  final ChatRepository _chatRepository;

  Future<void> setChatData(ChatModel data) async {
    await _chatRepository.setChatData(data);
  }

  Stream<List<ChatModel>> chatListStream(String chatRoomId) {
    return _chatRepository.chatListStream(chatRoomId);
  }
}
