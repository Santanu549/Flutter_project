import 'package:flutter/material.dart';

class FormFill extends StatelessWidget {
  FormFill({required this.fromHint, required this.conTroller});
  final String fromHint;
  final TextEditingController conTroller;
  @override
  Widget build(BuildContext context) {
    return Expanded(

      child: Container(

        decoration: BoxDecoration(
          color: Colors.amber.shade200,
          borderRadius: BorderRadius.circular(10),

        ),
        margin: EdgeInsets.all(10),

        child: Padding(
          padding: EdgeInsets.only(left: MediaQuery.of(context).size.height*0.02),
          child: TextField(
            controller: conTroller,
            decoration: InputDecoration(
              hintText: fromHint,
              border: InputBorder.none,
            ),


          ),
        ),
      ),
    );
  }
}
