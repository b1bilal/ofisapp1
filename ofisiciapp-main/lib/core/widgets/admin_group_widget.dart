import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ofisiciapp/core/constant/constants.dart';
import 'package:ofisiciapp/core/models/admin_group_model.dart';
import 'package:ofisiciapp/screens/admin/group_details.dart';

class AdminGroupWidget extends StatelessWidget {
  AdminGroupModel group;
  AdminGroupWidget({super.key, required this.group});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => GroupDetails(
                      name: group.name,
                    ))),
        trailing: IconButton(
          onPressed: () {},
          icon: Icon(
            CupertinoIcons.xmark,
            color: AppConstants().red,
          ),
        ),
        tileColor: AppConstants().grey,
        title: Text(group.name),
      ),
    );
  }
}
