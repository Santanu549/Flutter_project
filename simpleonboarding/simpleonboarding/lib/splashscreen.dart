import 'package:flutter/material.dart';
import 'package:simpleonboarding/home.dart';
import 'package:simpleonboarding/log_in/logIn.dart';
import 'package:simpleonboarding/onBoarding.dart';
import 'package:simpleonboarding/starting.dart';

import 'home.dart';
class splash extends StatefulWidget {
  const splash({Key? key}) : super(key: key);

  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> {
void initState(){
  super.initState();
  _navigatetohome();
}
_navigatetohome()async{
  await Future.delayed(Duration(milliseconds: 2000));
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Starting()));
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Container(
              color: Colors.transparent,
              child: Image.asset('assets/logo.png',
              height: 100,
              width: 100,),
              alignment: Alignment.center,


            ),
            Container(
              child: Text(
                'QUICKEY',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple
                ),
              ),
            ),
            SizedBox(height: 200,),
            Container(
              child: Text(
                'Made with love in india',
                style: TextStyle(
                  fontSize: 15,
                ),

              ),
            ),
          // Container(

             // padding: EdgeInsets.all(20),
            //  decoration: BoxDecoration(
               // color: Colors.deepPurple
            //  ),
           // )
          ],
        ),
      ),
    );
  }
}
