import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ofisiciapp/core/constant/constants.dart';
import 'package:ofisiciapp/core/provider/admin_chat_list_provider.dart';
import 'package:ofisiciapp/core/provider/admin_screen.dart';
import 'package:ofisiciapp/core/provider/create_group_attendees.dart';
import 'package:ofisiciapp/core/provider/create_group_select_list.dart';
import 'package:ofisiciapp/core/provider/person_message_provider.dart';
import 'package:ofisiciapp/firebase_options.dart';
import 'package:ofisiciapp/screens/admin/admin_panel.dart';
import 'package:ofisiciapp/screens/login/login.dart';
import 'package:ofisiciapp/screens/mainscreen.dart';
import 'package:ofisiciapp/screens/messages/message_screens/person_message.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AdminScreenIndex()),
        ChangeNotifierProvider(create: (_) => CreateGroupAttendees()),
        ChangeNotifierProvider(create: (_) => SelectListProvider()),
        ChangeNotifierProvider(create: (_) => PersonMessageProvider()),
        ChangeNotifierProvider(create: (_) => AdminChatListProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            floatingActionButtonTheme: FloatingActionButtonThemeData(
                backgroundColor: AppConstants().blue),
            appBarTheme: AppBarTheme(
                elevation: 0,
                backgroundColor: AppConstants().blue,
                centerTitle: true),
            scaffoldBackgroundColor: AppConstants().white,
            textTheme: GoogleFonts.montserratTextTheme()),
        debugShowCheckedModeBanner: false,
        home: FutureBuilder<Widget>(
          future: _firebaseLogin(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return snapshot.data!;
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ));
  }
}

Future<Widget> _firebaseLogin() async {
  FirebaseAuth auth = await FirebaseAuth.instance;
  print(auth.currentUser);
  if (auth.currentUser == null) {
    return LoginScreen();
  } else {
    FirebaseFirestore firestore = await FirebaseFirestore.instance;
    var data = await firestore.collection("Admin").get();

    if (data.docs.any((element) => element.id == auth.currentUser!.email)) {
      return AdminPanel();
    } else {
      return MainScreen();
    }
  }
}
