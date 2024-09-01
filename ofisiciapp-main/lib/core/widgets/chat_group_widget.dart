import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ofisiciapp/core/constant/constants.dart';
import 'package:ofisiciapp/core/models/group_chat_model.dart';
import 'package:ofisiciapp/screens/messages/group.dart';
import 'package:ofisiciapp/screens/messages/message_screens/group_message.dart';
import 'package:ofisiciapp/screens/messages/message_screens/person_message.dart';

import '../models/chat_model.dart';

class ChatGroupWidget extends StatelessWidget {
  const ChatGroupWidget({
    super.key,
    required this.chat,
  });
  final GroupChatModel chat;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, right: 20, left: 20),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        tileColor: AppConstants().grey,
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => GroupMessage(
                      name: chat.name,
                    ))),
        title: Text(
          chat.name,
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
        ),
        trailing: Icon(CupertinoIcons.right_chevron),
        leading: CircleAvatar(
          radius: 25,
          backgroundImage: NetworkImage(
            chat.photo,
          ),
        ),
      ),
    );
  }
}
