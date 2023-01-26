import 'package:flutter/material.dart';

class MyCoutomeButton extends StatelessWidget {
  const MyCoutomeButton({
    required this.colur,
    required this.borderLineColor,
    required this.buttonText,
    required this.prress
  });


  final Color colur;
  final Color borderLineColor;
  final String buttonText;
  final  prress;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 100,
      decoration: BoxDecoration(
        color: colur,
        borderRadius: BorderRadius.circular(50),
      ),

      child: TextButton(
        onPressed: prress,
        child: Text( buttonText,
          style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.black
          ),
        ),
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                  side: BorderSide(
                      color: borderLineColor,
                      width: 3
                  )
              )
          ),
        ),

      ),
    );
  }
}