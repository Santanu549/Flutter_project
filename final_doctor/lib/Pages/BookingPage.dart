import 'package:final_doctor/FormFill.dart';
import 'package:final_doctor/MyCoustomButton.dart';
import 'package:flutter/material.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({Key? key}) : super(key: key);
  static String id = "BookingPage";
  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  TextEditingController _new =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height*0.1,
              ),
              Text("Welcome!",
                style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height*0.03,
              ),
              Row(
                children: [
                  FormFill(
                    conTroller: _new,
                    fromHint: 'First Name',
                  ),
                  FormFill(
                    conTroller: _new,
                    fromHint: "Last Nme",
                  )
                ],
              ),
              Container(
                height: 69,
                  child: FormFill(
                    conTroller: _new,
                      fromHint: "Enter Phone Number")
                ,),
              Container(
                height: 69,
                child: FormFill(
                  conTroller: _new,
                    fromHint: "Adhar Number")
                ,),
              SizedBox(
                height: MediaQuery.of(context).size.height*0.1,
              ),
              MyCoutomeButton(
                  colur: Colors.amber.shade300,
                  borderLineColor: Colors.white,
                  buttonText: "Done",
                  prress: (){

                  },
              )
            ],
          ),
        ),
      ),
    );
  }
}
