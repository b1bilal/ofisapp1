import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ofisiciapp/core/constant/constants.dart';
import 'package:ofisiciapp/core/models/admin_group_person_model.dart';
import 'package:ofisiciapp/core/models/admin_person_model.dart';
import 'package:ofisiciapp/screens/admin/create_person.dart';
import 'package:ofisiciapp/screens/admin/person_details.dart';
import 'package:provider/provider.dart';

import '../provider/admin_chat_list_provider.dart';

class AdminPersonWidget extends StatelessWidget {
  AdminPersonModel person;
  AdminPersonWidget({super.key, required this.person});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        subtitle: Text(person.title),
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PersonDetails(
                      mail: person.mail,
                      name: person.name,
                      title: person.title,
                    ))),
        trailing: IconButton(
          onPressed: () => _firebaseDeleteUser(context, person.mail),
          icon: Icon(
            CupertinoIcons.xmark,
            color: AppConstants().red,
          ),
        ),
        tileColor: AppConstants().grey,
        title: Text(person.name),
      ),
    );
  }
}

_firebaseDeleteUser(BuildContext context, String mail) async {
  try {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    FirebaseAuth auth = FirebaseAuth.instance;
          context.read<AdminChatListProvider>().removeList(mail);

    var data1 = await firestore.collection("Users").doc(mail).get();
    auth
        .signInWithEmailAndPassword(email: mail, password: data1['password'])
        .then((value) => auth.currentUser!.delete())
        .then((value) async {
      firestore.collection("Users").doc(mail).delete();

      var data = await firestore.collection("Admin").get();
      auth.signInWithEmailAndPassword(
          email: data.docs.first.id, password: data.docs.first['pass']);
    });
  } catch (e) {
    print(e);
  }
}
