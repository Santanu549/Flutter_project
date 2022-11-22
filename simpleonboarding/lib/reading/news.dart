import 'package:flutter/material.dart';
import 'package:simpleonboarding/onBoarding.dart';

import '../log_in/logIn.dart';
class News extends StatefulWidget {
  const News({Key? key}) : super(key: key);

  @override
  State<News> createState() => _NewsState();
}

class _NewsState extends State<News> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/back.png'),
                fit: BoxFit.cover
            ),

          ),

          child:
          Center(
            child: Column(

              children: [
                SizedBox(height: 300,),

                Container(
                  child: Text(
                    'QNews',
                    style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,

                        color: Colors.white
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  child: Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'
                        ' Nunc vulputate libero et velit interdum, ac aliquet odio mattis.'
                        ' Class aptent taciti sociosqu ad litora torquent per conubia nostra, '
                        'per inceptos himenaeos.',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white
                    ),


                  ),
                ),
                SizedBox(height: 100,),
                Container(
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>onBoarding()));
                    },

                    child: Text(
                      'Skip',
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.white
                      ),
                    ),
                  ),

                ),
              ],
            ),
          )
      ),

    );
  }
}
