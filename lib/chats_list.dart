import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zego_zimkit/zego_zimkit.dart';

class ChatsList extends StatelessWidget {
  const ChatsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: ZIMKitConversationListView(
          onPressed: (context, conversation, defaultAction) {
            if (conversation.type == ZIMConversationType.group) {
              print("Group Chat Selected");
            } else {
              print("Single Chat Selected");
            }
            Get.to(
              () => ZIMKitMessageListPage(
                conversationID: conversation.id,
                conversationType: conversation.type,
              ),
            );
          },
        ),
      ),
    );
  }
}
