import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_chat_app/Models/UIHelper.dart';
import 'package:final_chat_app/Models/UserModel.dart';
import 'package:final_chat_app/Pages/MyHomePage.dart';
import 'package:final_chat_app/Pages/SignUp.dart';
import 'package:final_chat_app/Resources/FillBox.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';


class LogIn_Page extends StatefulWidget {
  const LogIn_Page({Key? key}) : super(key: key);

  @override
  State<LogIn_Page> createState() => _LogIn_PageState();
}

class _LogIn_PageState extends State<LogIn_Page> {
  TextEditingController emaiController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void checkValues(){
    String email = emaiController.text.trim();
    String pass = passwordController.text.trim();
    if(email == "" || pass == ""){
     UIHelper.showAlertDialuge("Incomplete data", "please fill all the fields", context);
    }
    else{
      logIn(email, pass);
    }
  }
  void logIn(String email, String Pass) async {

    UserCredential? credential;

    UIHelper.showLoading("Loging In...", context);
    try{
      credential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: Pass);
    } on FirebaseAuthException catch(ex){
      Navigator.pop(context);

      UIHelper.showAlertDialuge("An error Ocurred", ex.message.toString(), context);

    }
    if(credential != null){
      String uid = credential.user!.uid;
      DocumentSnapshot userData = await FirebaseFirestore.instance.collection("User").doc(uid).get();
      UserModel Umod = UserModel.fromMap(userData.data() as Map<String, dynamic>);
      Navigator.popUntil(context, (route) => route.isFirst);
      Navigator.pushReplacement(context, PageTransition(
          child: MyHomePage(
            userModel: Umod,
            firebaseuser: credential!.user!,
          ),
          type: PageTransitionType.rightToLeft
      ));
    }


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amberAccent.shade700,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: 40,
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text("Chat App",
                    style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 40,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  FillBox(
                    show: false,
                      ic: Icon(Icons.email_outlined),
                      emaiController: emaiController,
                      Txt: "Email",
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  FillBox(
                    show: true,
                    ic: Icon(Icons.password),
                      emaiController: passwordController,
                      Txt: "Password"
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30)
                    ),
                    child: CupertinoButton(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                        color: Colors.deepOrange[400],
                        child: Text(
                            "Log In",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white
                          ),
                        ),
                        onPressed: (){
                          checkValues();
                        }
                    ),
                  )
                ],
              ),
            ),
          ),
        ),

      ),
      bottomNavigationBar: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Do not have an account?",
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            CupertinoButton(
                child: Text(
                  "Sign Up",
                  style: TextStyle(
                    color: Colors.deepOrange[900],
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                  ),


                ),
                onPressed: (){
                  Navigator.push(context,
                      PageTransition(
                          child: SignUp_Page(),
                          duration: Duration(
                            milliseconds: 500,
                          ),
                          type: PageTransitionType.rightToLeft
                      )
                  );
                }
            )
          ],
        ),
      ),
    );
  }
}

