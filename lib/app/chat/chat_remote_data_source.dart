import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gdg_cloud_saitama_sample_chat_app/app/chat/chat_model.dart';
import 'package:gdg_cloud_saitama_sample_chat_app/cloud_firestore/cloud_firestore_service.dart';
import 'package:gdg_cloud_saitama_sample_chat_app/cloud_firestore/firestore_path.dart';

final chatRemoteDataSourceProvider = Provider<ChatRemoteDataSource>((ref) {
  return ChatRemoteDataSource(ref.watch(cloudFirestoreServiceProvider));
});

class ChatRemoteDataSource {
  ChatRemoteDataSource(this._cloudFirestoreService);

  final CloudFirestoreService _cloudFirestoreService;

  Future<void> setChatData(Map<String, dynamic> data) async {
    await _cloudFirestoreService.setData(
      path: FirestorePath.chatRoomPath(
          chatRoomId: data['chatRoomId'], chatId: data['id']),
      data: data,
    );
  }

  Stream<List<ChatModel>> chatListStream(String chatRoomId) {
    return _cloudFirestoreService.collectionStream(
      path: FirestorePath.chatRoomDomain(chatRoomId),
      builder: (data, _) => ChatModel.fromMap(data!),
      queryBuilder: (query) => query.orderBy('createdAt', descending: true),
    );
  }
}
