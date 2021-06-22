// import 'dart:convert';

// class ChatModel {
//   ChatModel(
//     this.id,
//     this.senderId,
//     this.text,
//     this.chatRoomId,
//     this.createdAt,
//   );

//   factory ChatModel.fromMap(Map<String, dynamic> map) {
//     return ChatModel(
//       map['id'],
//       map['senderId'],
//       map['text'],
//       map['chatRoomId'],
//       map['createdAt'].toDate(),
//     );
//   }

//   final String id;
//   final String senderId;
//   final String text;
//   final String chatRoomId;
//   final DateTime createdAt;

//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'senderId': senderId,
//       'text': text,
//       'chatRoomId': chatRoomId,
//       'createdAt': createdAt,
//     };
//   }
// }
