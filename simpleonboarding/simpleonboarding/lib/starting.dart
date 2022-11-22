import 'package:flutter/material.dart';
import 'package:simpleonboarding/log_in/logIn.dart';
import 'package:simpleonboarding/onBoarding.dart';
import 'package:simpleonboarding/reading/news.dart';
class Starting extends StatefulWidget {
  const Starting({Key? key}) : super(key: key);

  @override
  State<Starting> createState() => _StartingState();
}

class _StartingState extends State<Starting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              color: Colors.transparent,
              child: Image.asset('assets/logo.png',
                height: 100,
                width: 200,
              ),
            ),
            Container(
              color: Colors.transparent,
              child: Image.asset('assets/quikey.png',
                height: 100,
                width: 140,),
              alignment: Alignment.center,


            ),
           SizedBox(height: 25,),
           Container(
             child: Text('India''s first hyper active social meadia',
               style: TextStyle(
                 fontSize: 15,
                 color: Colors.blueGrey
               ),

             ),
           ),
           SizedBox(height: 200,),
           Container(
             padding: EdgeInsets.all(4),
             decoration: BoxDecoration(
               color: Colors.orange,
               borderRadius: BorderRadius.circular(25),
             ),
             child: TextButton(
               onPressed: (){
                 Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>News()));
               },
               child: Text(
                 'GET STARTED',
                 style: TextStyle(
                   fontSize: 15,
                   color: Colors.white
                 ),
               ),
             ),
           ),
            SizedBox(height: 100,),
            Container(
              child: Text(
                'Made with love in india',
                style: TextStyle(
                  fontSize: 15,
                ),

              ),
            ),

          ],
        ),
      ),
    );
  }
}
