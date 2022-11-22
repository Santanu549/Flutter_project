import 'package:flutter/material.dart';
class intro2 extends StatelessWidget {
  const intro2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:
        Container(
          child: Text(
            'This Is a Demo',
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
