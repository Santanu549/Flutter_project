import 'package:final_doctor/Pages/BookingPage.dart';
import 'package:final_doctor/Pages/CompounderForm.dart';
import 'package:final_doctor/Pages/CompounderLogInPage.dart';
import 'package:final_doctor/Pages/Initial.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:final_doctor/Pages/CompounderRegister.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      initialRoute: Initial.id,
      routes: {
        Initial.id : (context) => Initial(),
        CompounderForm.id : (context) => CompounderForm(),
        EmailPage.id : (context) => EmailPage(),
        LogInPage.id : (context) => LogInPage(),
        BookingPage.id : (context) => BookingPage(),
      },
    );
  }
}

