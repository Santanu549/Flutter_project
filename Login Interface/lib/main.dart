import 'package:calculator2/login.dart';
import 'package:calculator2/register.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: 'login',
    routes: {
      'login': (Context)=>MyLogin(),
      'register': (Context)=>MyRegister()
    },
  ));
}
