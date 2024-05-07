import 'package:doctor/LogInSignIn/FillBox.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '../MyCoustomButton/MyCoustomButton.dart';
class OTP extends StatefulWidget {
  const OTP({Key? key}) : super(key: key);

  @override
  State<OTP> createState() => _OTPState();
}

class _OTPState extends State<OTP> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[600],
      body: SafeArea(
          child: Column(

            children: [

              SizedBox(
                height: 80,
              ),

              Text("One Ttime Password",
              style: TextStyle(
                fontSize: 20,
              ),
              ),
              SizedBox(
                height: 20,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FillBox(
                      val: false,
                      HintText: "Enter OTP"
                  ),
                ],

              ),
              SizedBox(
                height: 50,
              ),


              MyCoutomeButton(
                prress: (){


                },
                colur: Colors.amber.shade400,
                borderLineColor: Colors.grey.shade300,
                buttonText: "Done",
              ),
            ],
          )
      ),
      
      
      
    );
  }
}
