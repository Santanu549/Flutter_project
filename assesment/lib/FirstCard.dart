import 'package:flutter/material.dart';

import 'CoustomCard.dart';

class FirstCard extends StatelessWidget {
  const FirstCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CoustomCard(
      colur: Colors.black,
      chil: Center(
        child: Column(
          children: [
            SizedBox(height: 15,),
            Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                CircleAvatar(
                  radius: 18,
                  backgroundImage: AssetImage("images/Ellipse 95.png"),
                ),
                SizedBox(
                  width: 10,
                ),
                Text('ETH',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16
                  ),
                ),
                Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.white,
                  size: 17,
                ),
                SizedBox(
                  width: 95,
                ),
                Text('1254',
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                  ),
                )

              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(
                  Icons.currency_rupee,
                  color: Colors.white,
                  size: 10,
                ),
                Text('0.00',
                  style: TextStyle(
                      color: Colors.white
                  ),
                ),
                SizedBox(
                  width: 30,
                )
              ],
            ),
            Row(

              children: [
                SizedBox(
                  width: 20,
                ),
                Text('Balance: 0.00',
                  style: TextStyle(
                      color: Colors.white
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

