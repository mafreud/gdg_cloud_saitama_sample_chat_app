import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'chat_model.dart';
import 'chat_remote_data_source.dart';
import '../../cloud_firestore/cloud_firestore_service.dart';
import '../../cloud_firestore/firestore_path.dart';

final chatRepositoryProvider = Provider<ChatRepository>((ref) {
  return ChatRepository(ref.watch(chatRemoteDataSourceProvider));
});

class ChatRepository {
  ChatRepository(this._chatRemoteDataSource);

  final ChatRemoteDataSource _chatRemoteDataSource;

  Future<void> setChatData(ChatModel data) async {
    await _chatRemoteDataSource.setChatData(data.toMap());
  }

  Stream<List<ChatModel>> chatListStream(String chatRoomId) {
    return _chatRemoteDataSource.chatListStream(chatRoomId);
  }
}
