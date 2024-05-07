import 'package:final_chat_app/Models/UIHelper.dart';
import 'package:final_chat_app/Models/UserModel.dart';
import 'package:final_chat_app/Pages/Profile.dart';
import 'package:final_chat_app/Resources/FillBox.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class SignUp_Page extends StatefulWidget {
  const SignUp_Page({Key? key}) : super(key: key);

  @override
  State<SignUp_Page> createState() => _SignUp_PageState();
}

class _SignUp_PageState extends State<SignUp_Page> {
  TextEditingController  emailController = TextEditingController();
  TextEditingController  passwordController = TextEditingController();
  TextEditingController  cpasswordController = TextEditingController();


  void checkValues(){
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String cpassword = cpasswordController.text.trim();
    if(email == "" || password=="" || cpassword == ""){
      UIHelper.showAlertDialuge("Incomplete data", "please fill all the fields", context);
    }
    else if(password != cpassword){
      UIHelper.showAlertDialuge
        ("Password is not matching", "Please fill password and confirm password with same", context);
    }
    else{
      SignUp(email, password);
    }

  }
  void SignUp(String email, String password) async {
    UserCredential? credential;
    UIHelper.showLoading("Creating new account...", context);

    try{
      credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch(ex){
      Navigator.pop(context);
      UIHelper.showAlertDialuge("An error Ocurred", ex.message.toString(), context);
    }
    if(credential != null){
      String uid = credential.user!.uid;
      UserModel newUser = UserModel(
          uid: uid,
          email: email,
          fullName: "",
          profilePic: ""
      );

      await FirebaseFirestore.instance.collection("User").doc(uid).set(newUser.toMap()).then((value){
        print("New user created");
        Navigator.popUntil(context, (route) => route.isFirst);
        Navigator.pushReplacement(context, PageTransition(
          child: Complete_profile(
            userModel: newUser,
            FibaseUser: credential!.user!,
          ),
          type: PageTransitionType.rightToLeft,
        )
        );
      });
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
                      emaiController: emailController,
                      Txt: "Email"
                  ),
                  SizedBox(
                    height: 5,
                  ),

                  FillBox(
                    show: true,
                    ic: Icon(Icons.password),
                      emaiController: passwordController,
                      Txt: "Password"
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  FillBox(
                    show: true,
                      ic: Icon(Icons.password),
                      emaiController: cpasswordController,
                      Txt: "Confirm Password"
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
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.deepOrange[400],
                        child: Text(
                            "Sign Up",
                          style: TextStyle(
                            fontWeight: FontWeight.bold
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
            Text("Already have an account",
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            CupertinoButton(
                child: Text(
                  "Log In",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                  ),

                ),
                onPressed: (){
                  Navigator.pop(context);
                }
            )
          ],
        ),
      ),
    );
  }
}
