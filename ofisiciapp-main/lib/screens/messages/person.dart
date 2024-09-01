import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ofisiciapp/core/models/admin_person_model.dart';
import 'package:ofisiciapp/core/models/chat_model.dart';
import 'package:ofisiciapp/core/widgets/chat_person_widget.dart';

class PersonMessage extends StatelessWidget {
  const PersonMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<ChatModel>>(
          future: _firestore(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) => ChatCard(
                  chat: snapshot.data![index],
                ),
              );
            } else
              return Center(
                child: CircularProgressIndicator(),
              );
          }),
    );
  }
}

Future<List<ChatModel>> _firestore() async {
  List<ChatModel> list = [];
  try {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    var data = await firestore.collection("Users").get();
    for (var element in data.docs) {
      if (element.id != auth.currentUser!.email) {
        list.add(ChatModel(
            foto: element.data().containsKey('photo') ? element['photo'] : null,
            name: element['name'],
            mail: element.id,
            title: element['title']));
      }
    }
  } catch (e) {
    print(e);
  }
  return list;
}
