import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ofisiciapp/core/constant/constants.dart';
import 'package:ofisiciapp/screens/messages/message_screens/person_message.dart';

import '../models/chat_model.dart';

class ChatCard extends StatelessWidget {
  const ChatCard({
    super.key,
    required this.chat,
  });
  final ChatModel chat;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10, right: 20, left: 20),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        tileColor: AppConstants().grey,
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PersonMessage(
                      mail: chat.mail,
                      name: chat.name,
                    ))),
        title: Text(
          chat.name,
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
        ),
        trailing: Icon(CupertinoIcons.right_chevron),
        leading: CircleAvatar(
            backgroundColor: AppConstants().white,
            radius: 25,
            backgroundImage: chat.foto != null
                ? NetworkImage(
                    chat.foto!,
                  )
                : null),
        subtitle: Text(
          chat.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
