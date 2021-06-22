import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'chat_model.dart';
import 'chat_remote_data_source.dart';
import 'chat_repository.dart';
import '../../cloud_firestore/cloud_firestore_service.dart';
import '../../cloud_firestore/firestore_path.dart';

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
