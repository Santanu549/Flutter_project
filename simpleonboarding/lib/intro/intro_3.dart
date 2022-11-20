import 'package:flutter/material.dart';
class intro3 extends StatelessWidget {
  const intro3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:
        Container(
          child: Text(
            'PRESS Done TO PROCEDE',
            style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold
            ),
          ),
        ),
      ),
      backgroundColor: Colors.deepOrange,
    );
  }
}
