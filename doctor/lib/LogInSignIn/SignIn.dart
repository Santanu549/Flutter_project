
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '../MyCoustomButton/MyCoustomButton.dart';
import 'FillBox.dart';
import 'OTP.dart';


class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);


  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[600],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(

              children: [

                Text("Register Here !",
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
                  height: 8,
                ),
                FillBox(
                    val: true,
                    HintText: "Confirm Password",
                ),

                SizedBox(
                  height: 80,
                ),




                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyCoutomeButton(
                      prress: (){

                          Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.rightToLeft,
                                duration: Duration(milliseconds: 450),
                                child: OTP()
                            ),
                          );



                      },
                      colur: Colors.amber.shade400,
                      borderLineColor: Colors.grey.shade300,
                      buttonText: "Done",
                    ),


                  ],
                ),
                SizedBox(
                  height: 15,
                ),


              ],
            ),
          ),
        ),
      ),
    );
  }
}
