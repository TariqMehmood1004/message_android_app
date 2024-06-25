import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zego_zimkit/zego_zimkit.dart';

class ChatsList extends StatelessWidget {
  const ChatsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ZIMKitConversationListView(
        itemBuilder: (context, conversations, child) {
          if (conversations == null) {
            return Center(child: Text('No chats available'));
          }
          return child;
        },
        onPressed: (context, conversation, defaultAction) {
          Get.to(
            () => ZIMKitMessageListPage(
              conversationID: conversation.id,
              conversationType: conversation.type,
            ),
          );
        },
      ),
    );
  }
}
