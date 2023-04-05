import 'package:flutter/material.dart';

import 'CoustomCard.dart';
class SecCard extends StatelessWidget {
  const SecCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CoustomCard(
      colur: Colors.blueGrey.shade800,
      chil: Column(

        children: [
          SizedBox(
            height: 25,
          ),
          Row(
            children: [
              SizedBox(
                width: 20,
              ),
              CircleAvatar(
                backgroundImage: AssetImage('images/Ellipse 95 (1).png'),
              ),
              SizedBox(width: 10,),
              Text('AAVE',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                ),
              ),
              Icon(
                Icons.keyboard_arrow_down,
                color: Colors.white,
                size: 17,
              ),
            ],
          ),
          SizedBox(height: 15,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 30,
              ),
              Text('Balance : 0.00',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 12
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

