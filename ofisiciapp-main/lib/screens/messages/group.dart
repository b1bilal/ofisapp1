import 'package:flutter/material.dart';
import 'package:ofisiciapp/core/models/admin_group_model.dart';
import 'package:ofisiciapp/core/models/group_chat_model.dart';
import 'package:ofisiciapp/core/widgets/admin_group_widget.dart';
import 'package:ofisiciapp/core/widgets/chat_group_widget.dart';

List<GroupChatModel> _models = [
  GroupChatModel(
      name: "Yazılım Ekibi",
      photo:
          "https://fotolifeakademi.com/uploads/2020/04/dusuk-isikta-fotograf-cekme-724x394.webp"),
  GroupChatModel(
      name: "Donanım Ekibi",
      photo:
          "https://fotolifeakademi.com/uploads/2020/04/dusuk-isikta-fotograf-cekme-724x394.webp")
];

class GroupMessages extends StatelessWidget {
  const GroupMessages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
            itemCount: _models.length,
            itemBuilder: (context, index) {
              return ChatGroupWidget(
                chat: _models[index],
              );
            }));
  }
}
