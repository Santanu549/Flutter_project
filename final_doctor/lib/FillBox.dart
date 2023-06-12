import 'package:flutter/material.dart';

class FillBox extends StatelessWidget {
  const FillBox({required this.val, required this.HintText, required this.ConTroLLer});
  final bool val;
  final String HintText;
  final TextEditingController ConTroLLer;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      decoration: BoxDecoration(
          color: Colors.amber[300],
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
              color: Colors.white,
              width: 2
          )

      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 30),
        child: TextField(
          controller: ConTroLLer,
          obscureText: val,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: HintText,
          ),



        ),
      ),
    );
  }
}