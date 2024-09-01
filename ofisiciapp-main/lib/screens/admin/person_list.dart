import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ofisiciapp/core/models/admin_person_model.dart';
import 'package:ofisiciapp/core/provider/admin_chat_list_provider.dart';
import 'package:ofisiciapp/core/widgets/admin_person_widget.dart';
import 'package:ofisiciapp/screens/admin/create_person.dart';
import 'package:provider/provider.dart';

class PersonList extends StatefulWidget {
  const PersonList({super.key});

  @override
  State<PersonList> createState() => _PersonListState();
}

class _PersonListState extends State<PersonList> {
  @override
  void initState() {
    super.initState();
    if (context.mounted) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        _firestore(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => CreatePerson())),
          child: Icon(CupertinoIcons.person_add_solid),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: ListView.builder(
              itemCount: context.watch<AdminChatListProvider>().list.length,
              itemBuilder: (context, index) {
                return AdminPersonWidget(
                    person: context.watch<AdminChatListProvider>().list[index]);
              }),
        ));
  }
}

_firestore(BuildContext context) async {
  context.read<AdminChatListProvider>().clearList();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  var data = await firestore.collection("Users").get();
  for (var element in data.docs) {
    context.read<AdminChatListProvider>().addList(AdminPersonModel(
        name: element['name'], mail: element.id, title: element['title']));
    /*  list.add(AdminPersonModel(
        name: element['name'], mail: element.id, title: element['title']));*/
  }
}
