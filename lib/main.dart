import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:notes/firebase_options.dart';
import 'package:notes/style/app_style.dart';
import 'package:notes/widgets/login_page.dart';
import 'package:notes/screen/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebaseproject/phoneAuth/nextPage.dart';
// import 'package:firebaseproject/email/home.dart';
// import 'package:firebaseproject/phoneAuth/phoneHome.dart';
// import 'package:firebaseproject/services/notification_services.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
