import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'chat_page_view_model.dart';
import '../../../colors.dart';
import '../../../constants.dart';

import '../chat_model.dart';

class ChatPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final viewModel = watch(chatPageViewModelProvider);
    return Scaffold(
      backgroundColor: FireColors.firebaseNavy,
      appBar: AppBar(
        backgroundColor: FireColors.firebaseNavy,
        title: Text('chat sample'),
      ),
      body: Column(
        children: [
          StreamBuilder<List<ChatModel>>(
              stream: viewModel.chatListStream('sampleChatRoom'),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const CircularProgressIndicator();
                }
                final chatList = snapshot.data;
                return _ChatBubbleList(chatList: chatList!);
              }),
          _BottomTextFieldWithSendButton(),
        ],
      ),
    );
  }
}

class _ChatBubbleList extends StatelessWidget {
  const _ChatBubbleList({required this.chatList});
  final List<ChatModel> chatList;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 8,
      child: ListView.builder(
        reverse: true,
        itemCount: chatList.length,
        itemBuilder: (context, index) {
          final chat = chatList[index];
          return _ChatBubble(chatModel: chat);
        },
      ),
    );
  }
}

class _ChatBubble extends StatelessWidget {
  const _ChatBubble({required this.chatModel});
  final ChatModel chatModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: isFirstUser(chatModel.senderId)
            ? MainAxisAlignment.start
            : MainAxisAlignment.end,
        children: [
          Card(
            shape: isFirstUser(chatModel.senderId)
                ? RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ))
                : RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  )),
            elevation: 3,
            color: isFirstUser(chatModel.senderId)
                ? FireColors.firebaseGray
                : FireColors.firebaseCoral,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(chatModel.text),
            ),
          ),
        ],
      ),
    );
  }

  bool isFirstUser(String userId) {
    if (userId == Constants.firstUserId) {
      return true;
    } else {
      return false;
    }
  }
}

class _BottomTextFieldWithSendButton extends ConsumerWidget {
  const _BottomTextFieldWithSendButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final viewModel = watch(chatPageViewModelProvider);
    return Flexible(
      child: Container(
        child: Row(
          children: [
            Expanded(
              flex: 4,
              child: TextField(
                controller: viewModel.textEditingController,
              ),
            ),
            Expanded(
              flex: 1,
              child: ElevatedButton(
                style:
                    ElevatedButton.styleFrom(primary: FireColors.firebaseBlue),
                onPressed: () async {
                  await viewModel.setChatData(Constants.firstUserId);
                },
                child: Text('Send'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
