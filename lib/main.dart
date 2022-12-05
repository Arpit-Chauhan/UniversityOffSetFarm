import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:univoffst/screens/dashboard.dart';
import 'package:univoffst/screens/login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var email = prefs.getString('email');
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: email == null
          ? LoginPage()
          : DashBoard(uid: FirebaseAuth.instance.currentUser!.uid),
    ),
  );
}
