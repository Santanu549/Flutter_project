import 'package:final_doctor/MyCoustomButton.dart';
import 'package:final_doctor/FillBox.dart';
import 'package:final_doctor/Pages/Profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({Key? key}) : super(key: key);
  static String id = "LogInPage";
  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  TextEditingController _emailController=TextEditingController();
  TextEditingController _passwordController=TextEditingController();
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Welcome!",
                style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height*0.03,
              ),
              FillBox(
                  val: false,
                  HintText: "Email Id",
                  ConTroLLer: _emailController,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height*0.01,
              ),
              FillBox(
                  val: true,
                  HintText: "Password",
                  ConTroLLer: _passwordController,


              ),
              SizedBox(
                height: MediaQuery.of(context).size.height*0.03,
              ),
              MyCoutomeButton(
                  colur: Colors.amber.shade300,
                  borderLineColor: Colors.white,
                  buttonText: "Done",
                  prress: () async {
                    try{
                      final user = await _auth.signInWithEmailAndPassword(
                          email: _emailController.text,
                          password: _passwordController.text,
                      );
                      if(user!=null){
                        Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.rightToLeft,
                              duration: Duration(milliseconds: 450),
                              child: Profile(),
                          ),
                        );

                      }
                    }catch(e){
                      print(e);
                    }

                  }

              ),
              SizedBox(
                height: MediaQuery.of(context).size.height*0.08,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
