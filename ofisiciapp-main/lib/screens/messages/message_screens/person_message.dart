import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:ofisiciapp/core/constant/constants.dart';
import 'package:ofisiciapp/core/models/message_model.dart';
import 'package:ofisiciapp/core/provider/person_message_provider.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';

TextEditingController _controller = TextEditingController();

class PersonMessage extends StatefulWidget {
  final mail;
  final name;
  const PersonMessage({super.key, required this.mail, required this.name});

  @override
  State<PersonMessage> createState() => _MessageState();
}

class _MessageState extends State<PersonMessage> {
  @override
  void initState() {
    super.initState();
    _controller.clear();
    if (context.mounted) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        _firestoreLoadChat(context, widget.mail);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(widget.name),
          elevation: 0,
          actions: [
            IconButton(onPressed: () {}, icon: Icon(CupertinoIcons.phone_fill))
          ],
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                    reverse: true,
                    itemCount:
                        context.watch<PersonMessageProvider>().list.length,
                    itemBuilder: (context, index) {
                      return context
                                  .watch<PersonMessageProvider>()
                                  .list[index]
                                  .file !=
                              null
                          ? Text(context
                              .watch<PersonMessageProvider>()
                              .list[index]
                              .file
                              .toString())
                          : Align(
                              alignment: !context
                                      .watch<PersonMessageProvider>()
                                      .list[index]
                                      .sendByMe
                                  ? Alignment.centerLeft
                                  : Alignment.centerRight,
                              child: Container(
                                  constraints: BoxConstraints(
                                    maxWidth:
                                        MediaQuery.of(context).size.width /
                                            8 *
                                            5,
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 20),
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  decoration: BoxDecoration(
                                      color: !context
                                              .watch<PersonMessageProvider>()
                                              .list[index]
                                              .sendByMe
                                          ? AppConstants().lightBlue
                                          : AppConstants().grey,
                                      borderRadius: BorderRadius.circular(12)),
                                  child: Text(
                                    context
                                        .watch<PersonMessageProvider>()
                                        .list[index]
                                        .text,
                                    style: TextStyle(
                                        color: !context
                                                .watch<PersonMessageProvider>()
                                                .list[index]
                                                .sendByMe
                                            ? AppConstants().white
                                            : AppConstants().black),
                                    textAlign: TextAlign.start,
                                  )));
                    }),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ConstrainedBox(
                      constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width - 160),
                      child: CupertinoTextField(controller: _controller)),
                  FloatingActionButton(
                      child: Icon(Icons.file_copy),
                      heroTag: "file",
                      onPressed: () => _pickFile(widget.mail)),
                  FloatingActionButton(
                    heroTag: "message",
                    onPressed: () {
                      context.read<PersonMessageProvider>().insertMessage(
                          MessageModel(
                              text: _controller.text,
                              date: DateTime.now().millisecondsSinceEpoch,
                              sendByMe: true));
                      _firebaseSendMessage(widget.mail);
                      _controller.clear();
                    },
                    child: Icon(CupertinoIcons.paperplane_fill),
                  )
                ],
              )
            ],
          ),
        )

        /* GroupedListView<MessageModel, DateTime>(
        elements: messages,
        groupBy: (message) =>
            DateTime(message.date.year, message.date.month, message.date.day),
        groupHeaderBuilder: (MessageModel message) => Container(
          decoration: BoxDecoration(
              color: AppConstants().pink.withAlpha(200),
              borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
          child: Center(
              widthFactor: 1,
              heightFactor: 1,
              child: Text(message.date.toString())),
        ),
        itemBuilder: (context, MessageModel message) => Align(
            alignment: !message.sendByMe
                ? Alignment.centerLeft
                : Alignment.centerRight,
            child: Container(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width / 8 * 5,
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                margin: const EdgeInsets.symmetric(vertical: 5),
                decoration: BoxDecoration(
                    color: !message.sendByMe
                        ? AppConstants().lightBlue
                        : AppConstants().grey,
                    borderRadius: BorderRadius.circular(12)),
                child: Text(
                  message.text,
                  style: TextStyle(
                      color: !message.sendByMe
                          ? AppConstants().white
                          : AppConstants().black),
                  textAlign: TextAlign.start,
                ))),
        useStickyGroupSeparators: true,
        floatingHeader: true,
        order: GroupedListOrder.DESC,
        reverse: true,
      ),*/
        );
  }
}

_pickFile(String otherUser) async {
  try {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    FirebaseStorage storage = FirebaseStorage.instance;
    if (result != null) {
      var pickedFile = result.files.first;
      final file = File(pickedFile.path!);
      var path =
          'files/${DateTime.now().microsecondsSinceEpoch}.${file.path.split("/").last.split(".").last}';
      print(path);
      Reference ref = storage.ref().child(path);
  

      UploadTask uploadTask = ref.putFile(file);

      var dowurl = await (await uploadTask).ref.getDownloadURL();
      print(dowurl.toString());

      FirebaseFirestore firestore = FirebaseFirestore.instance;
      FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      firestore
          .collection("Users")
          .doc(firebaseAuth.currentUser!.email)
          .collection(otherUser)
          .doc("Message")
          .set({
        "messages": FieldValue.arrayUnion([
          {
            "text": _controller.text,
            "sender": firebaseAuth.currentUser!.email,
            "date": DateTime.now().millisecondsSinceEpoch,
            "file": dowurl.toString()
          }
        ])
      }, SetOptions(merge: true));
      firestore
          .collection("Users")
          .doc(otherUser)
          .collection(firebaseAuth.currentUser!.email!)
          .doc("Message")
          .set({
        "messages": FieldValue.arrayUnion([
          {
            "text": _controller.text,
            "sender": firebaseAuth.currentUser!.email,
            "date": DateTime.now().millisecondsSinceEpoch,
            "file": dowurl.toString()
          }
        ])
      }, SetOptions(merge: true));
    } else {}
  } catch (e) {
    print(e);
  }
}

_firebaseSendMessage(String otherUser) async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  firestore
      .collection("Users")
      .doc(firebaseAuth.currentUser!.email)
      .collection(otherUser)
      .doc("Message")
      .set({
    "messages": FieldValue.arrayUnion([
      {
        "text": _controller.text,
        "sender": firebaseAuth.currentUser!.email,
        "date": DateTime.now().millisecondsSinceEpoch
      }
    ])
  }, SetOptions(merge: true));
  firestore
      .collection("Users")
      .doc(otherUser)
      .collection(firebaseAuth.currentUser!.email!)
      .doc("Message")
      .set({
    "messages": FieldValue.arrayUnion([
      {
        "text": _controller.text,
        "sender": firebaseAuth.currentUser!.email,
        "date": DateTime.now().millisecondsSinceEpoch
      }
    ])
  }, SetOptions(merge: true));
}

_firestoreLoadChat(BuildContext context, String otherUser) async {
  context.read<PersonMessageProvider>().clearList();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  var data = await firestore
      .collection("Users")
      .doc(auth.currentUser!.email)
      .collection(otherUser)
      .doc("Message")
      .get();
  for (var element in data['messages']) {
    print(element['text']);
    context.read<PersonMessageProvider>().insertMessage(MessageModel(
        file: element.containsKey('file') ? element['file'] : null,
        text: element['text'],
        date: element['date'],
        sendByMe: element['sender'] == auth.currentUser!.email));
  }
}
