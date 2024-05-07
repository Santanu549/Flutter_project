import 'package:flutter/material.dart';

class FillBox extends StatelessWidget {
  const FillBox({
    super.key,
    required this.emaiController,
    required this.Txt, required this.ic, required this.show
  });

  final TextEditingController emaiController;
  final String Txt;
  final Icon ic;
  final bool show;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      decoration: BoxDecoration(
          color: Colors.yellow,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
              color: Colors.white,
              width: 2
          )
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 0, 30, 0),
        child: TextField(

          obscuringCharacter: "*",
          obscureText: show,
          controller: emaiController,
          decoration: InputDecoration(
            hintText: Txt,
            icon: ic,
            border: InputBorder.none,

          ),
        ),
      ),
    );
  }
}