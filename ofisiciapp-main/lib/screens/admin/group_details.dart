import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ofisiciapp/core/constant/constants.dart';
import 'package:ofisiciapp/core/models/admin_group_person_model.dart';
import 'package:ofisiciapp/core/widgets/admin_group_person_widget.dart';

List<AdminGroupPersonModel> _list = [
  AdminGroupPersonModel(name: "Hüseyin SEZEN", mail: "hsezen351@gmail.com")
];

class GroupDetails extends StatelessWidget {
  final name;
  const GroupDetails({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Height_20,
              CircleAvatar(
                backgroundColor: AppConstants().grey,
                radius: 100,
              ),
              Height_20,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Kişiler",
                    style: TextStyle(fontSize: 18),
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        CupertinoIcons.add,
                        color: AppConstants().eggBlue,
                      ))
                ],
              ),
              Height_10,
              for (var i = 0; i < _list.length; i++) ...[
                AdminGroupPersonWidget(person: _list[i])
              ]
            ],
          ),
        ),
      ),
    );
  }
}
