import 'package:final_doctor/MyCoustomButton.dart';
import 'package:final_doctor/FillBox.dart';
import 'package:final_doctor/Pages/Profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';


class EmailPage extends StatefulWidget {
  const EmailPage({Key? key}) : super(key: key);
  static String id = "CompounderEmailPage";



  @override
  State<EmailPage> createState() => _EmailPageState();
}

class _EmailPageState extends State<EmailPage> {
  TextEditingController _emailController=TextEditingController();
  TextEditingController _passwordController=TextEditingController();
  TextEditingController _confirmPass=TextEditingController();
  String _Warning="";
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.15,
                ),
                Text("Register Here!",
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
                  height: MediaQuery.of(context).size.height*0.01,
                ),
                FillBox(
                    val: true,
                    HintText: "Confirm Password",
                  ConTroLLer: _confirmPass,

                ),
                Text(_Warning,
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
                ),

                SizedBox(
                  height: MediaQuery.of(context).size.height*0.3,
                ),
                MyCoutomeButton(
                    colur: Colors.amber.shade300,
                    borderLineColor: Colors.white,
                    buttonText: "Done",
                    prress: () async {
                    if(_passwordController.text==_confirmPass.text){
                      setState(() {
                        _Warning="";
                      });
                      try{
                        final NewUser = await _auth.createUserWithEmailAndPassword(
                            email: _emailController.text,
                            password: _passwordController.text
                        );
                        if(NewUser!=null){
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
                    }else{
                      setState(() {
                        _Warning="Password is not matching";
                      });
                    }

                    }
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}
