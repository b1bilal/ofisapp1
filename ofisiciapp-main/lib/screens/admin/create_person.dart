import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ofisiciapp/core/constant/constants.dart';
import 'package:ofisiciapp/core/models/admin_person_model.dart';
import 'package:ofisiciapp/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import '../../core/provider/admin_chat_list_provider.dart';

TextEditingController _mail = TextEditingController();
TextEditingController _pass = TextEditingController();
TextEditingController _name = TextEditingController();
TextEditingController _title = TextEditingController();

class CreatePerson extends StatelessWidget {
  const CreatePerson({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Yeni Kişi")),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Height_20,
              Text("E-Mail"),
              Height_10,
              CupertinoTextField(
                controller: _mail,
                keyboardType: TextInputType.emailAddress,
              ),
              Height_20,
              Text("Şifre"),
              Height_10,
              CupertinoTextField(controller: _pass),
              Height_20,
              Text("Ad Soyad"),
              Height_10,
              CupertinoTextField(controller: _name),
              Height_20,
              Text("Lakap"),
              Height_10,
              CupertinoTextField(controller: _title),
              Height_100,
              CupertinoButton(
                  color: AppConstants().eggBlue,
                  child: Center(child: Text("Oluştur")),
                  onPressed: () => _firebaseCreateUser(context))
            ],
          ),
        ),
      ),
    );
  }
}

_firebaseCreateUser(BuildContext context) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  try {
    context.read<AdminChatListProvider>().addList(AdminPersonModel(
        name: _name.text, mail: _mail.text, title: _title.text));

    auth
        .createUserWithEmailAndPassword(email: _mail.text, password: _pass.text)
        .then((value) {
      firestore.collection("Users").doc(_mail.text).set({
        "name": _name.text,
        "title": _title.text,
        "password": _pass.text
      }).then((value) async {
        var data = await firestore.collection("Admin").get();
        auth.signInWithEmailAndPassword(
            email: data.docs.first.id, password: data.docs.first['pass']);

        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Kullanıcı Başarıyla Oluşturulmuştur')));
      });
    });
  } on FirebaseAuthException catch (e) {
    print(e);
  }
}
