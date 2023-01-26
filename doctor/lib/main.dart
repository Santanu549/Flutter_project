import 'package:doctor/LogInSignIn/logIn.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'MyCoustomButton/MyCoustomButton.dart';

void main() {

  WidgetsFlutterBinding();
  SystemChrome.setPreferredOrientations(
  [
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp
  ]

  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[600],
      body: Center(
        child: Column(

          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height*0.1,
            ),
            CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage: AssetImage("Images/doct.png"),
              radius: 60,

            ),

            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.black,
              ),
              margin: EdgeInsets.only(top: 20),

              width: 250,
              height: 30,
              child: Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text("       D o c t o r   A p p o i n t m e n t",

                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white

                ),
                ),
              ),
            ),



            SizedBox(
              height: MediaQuery.of(context).size.height*0.005,
            ),


            Text("Easy Booking",
              style: TextStyle(
                fontWeight: FontWeight.bold
              ),
            ),




            SizedBox(
              height: MediaQuery.of(context).size.height*0.4,
            ),






            MyCoutomeButton(
              prress: (){},
              colur: Colors.amber.shade400,
              borderLineColor: Colors.grey.shade300,
              buttonText: "Patient",

            ),



            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Register as",
                style: TextStyle(
                  color: Colors.white
                ),
                ),
                TextButton(
                    onPressed: (){
                      Navigator.push(context, PageTransition(
                          type: PageTransitionType.rightToLeft,
                          duration: Duration(milliseconds: 450),
                          child: LogIn()));

                    },
                    child: Text("Compunder",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold
                    ),
                    ),
                ),
              ],
            )

          ],



        ),
      ),
    );
  }
}





