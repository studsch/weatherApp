// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'package:weather/firebase_options.dart';
// import 'package:weather/ui/auth_page.dart';
import 'package:weather/ui/login_page.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // const?
    return const MaterialApp(
      title: "Weather",
      home: LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
