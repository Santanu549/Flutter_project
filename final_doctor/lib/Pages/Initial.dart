import 'package:final_doctor/MyCoustomButton.dart';
import 'package:final_doctor/Pages/CompounderForm.dart';
import 'package:final_doctor/Pages/CompounderLogInPage.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class Initial extends StatefulWidget {
  const Initial({Key? key}) : super(key: key);
  static String id="initial";

  @override
  State<Initial> createState() => _InitialState();
}

class _InitialState extends State<Initial> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber.shade600,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height*0.1,
              ),
              CircleAvatar(
                backgroundColor: Colors.brown,
                radius: 65,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage("Images/doctor.png"),
                  radius: 60,
                ),
              ),
          SizedBox(
            height: MediaQuery.of(context).size.height*0.02,
          ),
          Container(
            height: 80,
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Image(
              image: AssetImage("Images/logo.png"),
            ),
          ),
            SizedBox(
              height: MediaQuery.of(context).size.height*0.3,
            ),
            MyCoutomeButton(
                colur: Colors.amber.shade300,
                borderLineColor: Colors.white,
                buttonText: "Book",
                prress: (){

                },
            ),
              SizedBox(
                height: MediaQuery.of(context).size.height*0.01,
              ),
              MyCoutomeButton(
                  colur: Colors.amber.shade300,
                  borderLineColor: Colors.white,
                  buttonText: "LogIn",
                  prress: (){
                    Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.rightToLeft,
                          duration: Duration(milliseconds: 450),
                          child: LogInPage(),
                      ),
                    );


                  },
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height*0.03,
              ),

              GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.rightToLeft,
                        duration: Duration(milliseconds: 450),
                        child: CompounderForm(),
                    ),
                  );
                },
                child: Text("Register as Compounder",
                style: TextStyle(
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
                ),
              ),



            ],
          ),
        ),
      ),
    );
  }
}
