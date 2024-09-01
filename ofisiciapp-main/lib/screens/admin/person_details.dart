import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ofisiciapp/core/constant/constants.dart';
import 'package:ofisiciapp/core/models/admin_person_model.dart';
import 'package:ofisiciapp/core/provider/admin_chat_list_provider.dart';
import 'package:provider/provider.dart';

late TextEditingController _name;

late TextEditingController _title;

class PersonDetails extends StatefulWidget {
  final name;
  final title;
  final mail;
  const PersonDetails(
      {super.key, required this.name, required this.title, required this.mail});

  @override
  State<PersonDetails> createState() => _PersonDetailsState();
}

class _PersonDetailsState extends State<PersonDetails> {
  @override
  void initState() {
    super.initState();
    _name = TextEditingController(text: widget.name);
    _title = TextEditingController(text: widget.title);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Kişi Detayları")),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Height_40,
              Text("İsim Soyisim"),
              Height_10,
              CupertinoTextField(controller: _name),
              Height_20,
              Text("Lakap"),
              Height_10,
              CupertinoTextField(controller: _title),
              Spacer(),
              CupertinoButton(
                  color: AppConstants().blue,
                  child: Center(child: Text("Güncelle")),
                  onPressed: () => _firebaseUpdate(
                      context, widget.name, widget.title, widget.mail)),
              Height_50
            ],
          ),
        ),
      ),
    );
  }
}

_firebaseUpdate(
    BuildContext context, String name, String title, String mail) async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  try {
    firestore.collection("Users").doc(mail).set(
        {"name": _name.text, "title": _title.text},
        SetOptions(merge: true)).then((value) {
      context.read<AdminChatListProvider>().removeList(mail);
      context.read<AdminChatListProvider>().addList(
          AdminPersonModel(mail: mail, name: _name.text, title: _title.text));
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Kullanıcı Güncellenmiştir')));
      Navigator.pop(context);
    });
  } catch (e) {}
}
