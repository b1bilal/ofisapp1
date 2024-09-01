import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ofisiciapp/core/constant/constants.dart';
import 'package:ofisiciapp/core/provider/admin_screen.dart';
import 'package:ofisiciapp/screens/admin/group_list.dart';
import 'package:ofisiciapp/screens/admin/person_list.dart';
import 'package:ofisiciapp/screens/login/login.dart';
import 'package:provider/provider.dart';
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';

class AdminPanel extends StatefulWidget {
  const AdminPanel({super.key});

  @override
  State<AdminPanel> createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  List<Widget> bodyList = [PersonList(), GroupList()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Admin Paneli"),
      ),
      endDrawer: Drawer(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          CupertinoButton(
              color: AppConstants().red,
              onPressed: () => _firebaseSignOut(context),
              child: Text("Çıkış Yap")),
          Height_50
        ],
      )),
      body: bodyList[context.watch<AdminScreenIndex>().selectedIndex],
      bottomNavigationBar: WaterDropNavBar(
        onItemSelected: (int index) {
          context.read<AdminScreenIndex>().changeIndex(index);
        },
        selectedIndex: context.watch<AdminScreenIndex>().selectedIndex,
        barItems: <BarItem>[
          BarItem(
            filledIcon: Icons.person_2,
            outlinedIcon: Icons.person_2_outlined,
          ),
          BarItem(
              filledIcon: Icons.people,
              outlinedIcon: Icons.people_outline_outlined)
        ],
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
