import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ofisiciapp/core/constant/constants.dart';
import 'package:ofisiciapp/core/models/admin_group_person_model.dart';

class AdminGroupPersonWidget extends StatelessWidget {
  AdminGroupPersonModel person;
  AdminGroupPersonWidget({super.key, required this.person});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: AppConstants().grey,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      title: Text(person.name),
      trailing: IconButton(
          onPressed: () {},
          icon: Icon(
            CupertinoIcons.xmark,
            color: AppConstants().red,
          )),
    );
  }
}
