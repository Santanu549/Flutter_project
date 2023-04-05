import 'package:flutter/material.dart';
class CoustomCard extends StatelessWidget {
  const CoustomCard({
    required this.colur,
    required this.chil
  });
final Color colur;
final Widget chil;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      width: 300,

      decoration: BoxDecoration(
          color: colur,
          borderRadius: BorderRadius.circular(20)
      ),
      child:  chil,
    );
  }
}
