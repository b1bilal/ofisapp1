import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ofisiciapp/core/constant/constants.dart';
import 'package:ofisiciapp/core/models/admin_group_person_model.dart';
import 'package:ofisiciapp/core/provider/create_group_attendees.dart';
import 'package:ofisiciapp/core/provider/create_group_select_list.dart';
import 'package:provider/provider.dart';

class CreateGroup extends StatefulWidget {
  const CreateGroup({super.key});

  @override
  State<CreateGroup> createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  @override
  void initState() {
    super.initState();
    context.read<SelectListProvider>().clearList();
    context.read<CreateGroupAttendees>().clearList();
    context.read<SelectListProvider>().addAttendee(AdminGroupPersonModel(
        name: "Hüseyin SEZEN", mail: "hsezen351@gmail.com"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Yeni Grup Oluştur")),
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
              Align(alignment: Alignment.centerLeft, child: Text("Grup İsmi")),
              Height_10,
              CupertinoTextField(),
              Height_20,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Grup Üyeleri"),
                  IconButton(
                      onPressed: () {
                        showModalBottomSheet<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              height: 500,
                              color: AppConstants().white,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Align(
                                          alignment: Alignment.centerLeft,
                                          child: const Text('Grup Üyesi Ekle')),
                                      Height_20,
                                      for (var element in context
                                          .read<SelectListProvider>()
                                          .list) ...[
                                        Padding(
                                          padding: EdgeInsets.only(bottom: 10),
                                          child: CupertinoButton(
                                              color: AppConstants().grey,
                                              child: Center(
                                                  child: Text(
                                                element.name,
                                                style: TextStyle(
                                                    color: AppConstants().blue),
                                              )),
                                              onPressed: () {
                                                context
                                                    .read<
                                                        CreateGroupAttendees>()
                                                    .addAttendee(element);
                                                Navigator.pop(context);
                                              }),
                                        ),
                                      ]
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                      icon: Icon(
                        CupertinoIcons.add,
                        color: AppConstants().eggBlue,
                      ))
                ],
              ),
              for (var element
                  in context.watch<CreateGroupAttendees>().list) ...[
                ListTile(
                  title: Text(element.name),
                  trailing: IconButton(
                      onPressed: () {
                        context
                            .read<CreateGroupAttendees>()
                            .removeAttendee(element);
                      },
                      icon: Icon(
                        CupertinoIcons.xmark,
                        color: AppConstants().red,
                      )),
                ),
              ],
              Height_60,
              CupertinoButton(
                  onPressed: () {},
                  color: AppConstants().eggBlue,
                  child: Center(child: Text("Grup Oluştur"))),
              Height_20
            ],
          ),
        ),
      ),
    );
  }
}
