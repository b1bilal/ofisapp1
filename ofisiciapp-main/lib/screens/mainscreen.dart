import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ofisiciapp/core/constant/constants.dart';
import 'package:ofisiciapp/screens/login/login.dart';
import 'package:ofisiciapp/screens/messages/group.dart';
import 'package:ofisiciapp/screens/messages/person.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        endDrawer: SafeArea(
          child: Drawer(
            child: Column(
              children: [
                Height_20,
                Text("Aydın Pazarlama"),
                Height_20,
                CircleAvatar(
                  backgroundColor: AppConstants().grey,
                  radius: 100,
                ),
                Height_10,
                Text(
                  "Hüseyin SEZEN",
                  style: TextStyle(fontSize: 18),
                ),
                Height_10,
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    decoration: BoxDecoration(
                        color: AppConstants().pink.withAlpha(150),
                        borderRadius: BorderRadius.circular(12)),
                    child: Text(
                      "Lakap",
                      style: TextStyle(color: AppConstants().white),
                    )),
                Spacer(),
                CupertinoButton(
                  child: Text("Çıkış Yap"),
                  onPressed: () => _firebaseSignOut(context),
                  color: AppConstants().red,
                ),
                Height_50
              ],
            ),
          ),
        ),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: AppConstants().blue,
          title: Text(
            "Aydın Pazarlama",
            style: TextStyle(color: AppConstants().white),
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              color: AppConstants().blue,
            ),
          ),
          bottom: TabBar(
            indicatorColor: AppConstants().white,
            indicatorWeight: 4,
            isScrollable: false,
            tabs: [
              Tab(
                text: "Sohbet",
              ),
              Tab(
                text: "Gruplar",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            PersonMessage(),
            GroupMessages(),
          ],
        ),
      ),
    );
  }
}

_firebaseSignOut(context) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  Navigator.popUntil(context, (route) => route.isFirst);
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => LoginScreen()));
  auth.signOut();
}
