

import 'package:final_doctor/MyCoustomButton.dart';
import 'package:final_doctor/FormFill.dart';
import 'package:final_doctor/Pages/CompounderRegister.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CompounderForm extends StatefulWidget {
  const CompounderForm({Key? key}) : super(key: key);
  static String id = "Compounder";

  @override
  State<CompounderForm> createState() => _CompounderFormState();
}

class _CompounderFormState extends State<CompounderForm> {
  TextEditingController _fNameCon = TextEditingController();
  TextEditingController _lNameCon = TextEditingController();
  TextEditingController _CityNameCon = TextEditingController();
  TextEditingController _Desc = TextEditingController();
  final _fireStore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height*0.03,
              ),
              Text("Welcome!",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold
              ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height*0.03,
              ),
              Row(
                children: [
                  FormFill(
                   conTroller: _fNameCon,
                    fromHint: 'First Name',
                  ),
                  FormFill(
                    conTroller: _lNameCon,
                    fromHint: "Last Nme",
                  )
                ],
              ),
              Container(
                height: 70,
                child: FormFill(
                  conTroller: _CityNameCon,
                  
                    fromHint: "Enter City Name",
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height*0.4,
                  child: FormFill(
                     conTroller: _Desc,
                      fromHint: "Description"
                  ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height*0.08,
              ),
              MyCoutomeButton(
                  colur: Colors.amber.shade300,
                  borderLineColor: Colors.white,
                  buttonText: "Next",
                  prress: () async {
                    _fireStore.collection("Details").add({
                      'City' : _CityNameCon.text.toString(),
                      'Description' : _Desc.text.toString(),
                      'Fname' : _fNameCon.text.toString(),
                      'Lname' : _lNameCon.text.toString(),
                    });


                    Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.rightToLeft,
                          duration: Duration(milliseconds: 450),
                          child: EmailPage(),
                      ),
                    );

                  },
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

