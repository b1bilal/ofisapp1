import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ofisiciapp/core/constant/constants.dart';
import 'package:ofisiciapp/screens/admin/admin_panel.dart';
import 'package:ofisiciapp/screens/mainscreen.dart';

TextEditingController _mail = TextEditingController();
TextEditingController _pass = TextEditingController();

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
    _mail.clear();
    _pass.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Container(
                constraints: BoxConstraints.expand(),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/arka.jpg"), fit: BoxFit.cover),
                ),
              ),
              Column(
                children: [
                  SizedBox(
                    height: 175,
                  ),
                  Align(
                    child: Container(
                      height: 550,
                      width: 350,
                      decoration: BoxDecoration(
                        color: AppConstants().white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.only(left: 25, top: 25),
                            alignment: Alignment.topLeft,
                            child: Text("Hoşgeldiniz,"),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          kutu(
                            isEmail: true,
                            controller: _mail,
                            hint: "e-mail",
                            label: "E-mail",
                            ikon: Icon(CupertinoIcons.mail_solid),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          kutu(
                            isEmail: false,
                            controller: _pass,
                            hint: "Şifre",
                            label: "Sifre",
                            ikon: Icon(Icons.key),
                          ),
                          SizedBox(
                            height: 120,
                          ),
                          SizedBox(
                            width: 180,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () => _firebaseLogin(context),
                              child: Text("Giriş Yap"),
                              style: ElevatedButton.styleFrom(
                                shape: StadiumBorder(),
                                backgroundColor: AppConstants().blue,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 36,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class kutu extends StatelessWidget {
  kutu({
    required this.hint,
    required this.label,
    required this.ikon,
    required this.controller,
    required this.isEmail,
    super.key,
  });
  bool isEmail;
  String hint;
  String label;
  TextEditingController controller;
  final ikon;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      child: Form(
        child: TextFormField(
          keyboardType:
              isEmail ? TextInputType.emailAddress : TextInputType.text,
          controller: controller,
          obscureText: isEmail ? false : true,
          decoration: InputDecoration(
              hintText: hint,
              labelText: label,
              labelStyle: TextStyle(color: AppConstants().blue),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: AppConstants().eggBlue),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: AppConstants().blue),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: AppConstants().eggBlue),
              ),
              suffixIcon: ikon,
              suffixIconColor: AppConstants().eggBlue),
        ),
      ),
    );
  }
}

Future _firebaseLogin(BuildContext context) async {
  try {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    auth
        .signInWithEmailAndPassword(email: _mail.text, password: _pass.text)
        .then((value) async {
      var data = await firestore.collection("Admin").get();

      if (data.docs.any((element) => element.id == _mail.text)) {
        Navigator.popUntil(context, (route) => route.isFirst);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => AdminPanel()));
      } else {
        Navigator.popUntil(context, (route) => route.isFirst);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => MainScreen()));
      }
    });
  } on FirebaseAuthException catch (e) {}
}
