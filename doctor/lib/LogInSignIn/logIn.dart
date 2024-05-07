import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:page_transition/page_transition.dart';
import '../MyCoustomButton/MyCoustomButton.dart';
import 'FillBox.dart';
import 'SignIn.dart';




class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[600],
      body: SafeArea(
        child: Center(
          child: Column(

            children: [
              SizedBox(
                height: 100,
              ),
              Text("Welcome !",
              style: TextStyle(
                fontSize: 30,
                color: Colors.black,
                fontWeight: FontWeight.bold
              ),
              ),

              SizedBox(
                height: 50,
              ),

              FillBox(

                val: false,
              HintText: "Email",
              ),
              SizedBox(
                height: 8,
              ),
              FillBox(
                val: true,
              HintText: "Password",
              ),
              SizedBox(
                height: 20,
              ),


              SizedBox(
                height: 50,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyCoutomeButton(
                    prress: (){},
                    colur: Colors.amber.shade400,
                    borderLineColor: Colors.grey.shade300,
                    buttonText: "LogIn",
                  ),
                  SizedBox(
                    width: 80,
                  ),

                  MyCoutomeButton(
                   prress: (){
                     Navigator.push(context, PageTransition(
                         type: PageTransitionType.rightToLeft,
                         duration: Duration(milliseconds: 450),
                         child: SignIn()));
                   },
                    colur: Colors.amber.shade400,
                    borderLineColor: Colors.grey.shade300,
                    buttonText: "SignIn",

                  ),

                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 190,
                  ),


                  Text("If you are new\npress SignIn",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[500],
                    fontStyle: FontStyle.italic
                  ),
                  )
                ],

              ),

            ],
          ),
        ),
      ),
    );
  }
}





