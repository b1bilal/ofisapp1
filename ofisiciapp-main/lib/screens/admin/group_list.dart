import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ofisiciapp/core/models/admin_group_model.dart';
import 'package:ofisiciapp/core/widgets/admin_group_widget.dart';
import 'package:ofisiciapp/screens/admin/create_group.dart';

List<AdminGroupModel> _list = [
  AdminGroupModel(name: "Yazılım Ekibi"),
  AdminGroupModel(name: "Tasarım Ekibi")
];

class GroupList extends StatelessWidget {
  const GroupList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => CreateGroup())),
        child: Icon(CupertinoIcons.add),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: ListView.builder(
            itemCount: _list.length,
            itemBuilder: (context, index) {
              return AdminGroupWidget(group: _list[index]);
            }),
      ),
    );
  }
}
