import 'package:flutter/material.dart';
class intro1 extends StatelessWidget {
  const intro1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:
        Container(
          child: Text(
            'WELCOME PRESS: Skip OR Next',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold
            ),
          ),
        ),
      ),
      backgroundColor: Colors.red,
    );
  }
}
