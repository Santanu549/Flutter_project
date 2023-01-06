import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
       home: Scaffold(
         backgroundColor: Colors.red,
         appBar: AppBar(
           backgroundColor: Colors.red,
           title: Text("Dice",
           style: TextStyle(
             fontSize: 30,
           ),),
         ),
         body:
         MyApp(),
       ),
    )
  );
}
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int rightInt=1;
  int leftInt=1;
  void changeFace(){
    setState(() {
      rightInt=Random().nextInt(6)+1;
      leftInt=Random().nextInt(6)+1;
    });
  }
  @override
  Widget build(BuildContext context) {
    return    Center(
      child: Row(
        children: [
          Expanded(
            child: TextButton(
                onPressed: (){
                  changeFace();
                },
                child: Image.asset("Images/dice$leftInt.png")),
          ),
          Expanded(
            child: TextButton(
                onPressed: (){
                  changeFace();
                },
                child: Image.asset("Images/dice$rightInt.png")),
          )

        ],
      ),
    );
  }
}



