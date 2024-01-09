import 'package:flutter/material.dart';

import 'package:diary/Login/login.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Project',
      theme: ThemeData(
        iconTheme: IconThemeData(
          color: const Color.fromARGB(255, 15, 75, 124),
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        primaryColor: Colors.blue, // Change the primary color of the app
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const Scaffold(body: LoginPage()),
    );
  }
}
