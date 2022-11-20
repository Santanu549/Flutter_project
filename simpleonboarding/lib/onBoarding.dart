import 'package:flutter/material.dart';
import 'package:simpleonboarding/intro/intro_1.dart';
import 'package:simpleonboarding/intro/intro_2.dart';
import 'package:simpleonboarding/intro/intro_3.dart';
import 'package:simpleonboarding/log_in/logIn.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'home.dart';
class onBoarding extends StatefulWidget {
  const onBoarding({Key? key}) : super(key: key);

  @override
  State<onBoarding> createState() => _onBoardingState();
}

class _onBoardingState extends State<onBoarding> {
  PageController _controller = PageController();
  bool OnlastPage = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [PageView(
          controller: _controller,
          onPageChanged: (index){
            setState(() {
              OnlastPage = (index == 2);
            });

          },
          children: [
            intro1(),
            intro2(),
            intro3(),

          ],
        ),
          Container(
            alignment: Alignment(0, 0.7),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(onTap: (){
                  _controller.jumpToPage(2);
          },
                    child: Text('Skip',
                      style: TextStyle(
                        fontSize: 20,

                      ),
                    )),
                SmoothPageIndicator(controller: _controller,
                count: 3,),
                OnlastPage?
                GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>LogIn()));

                    },
                    child: Text('Done',
                    style: TextStyle(
                      fontSize: 20,
                    ),)
                ) :GestureDetector(
                    onTap: (){
                      _controller.nextPage(duration:
                      Duration(milliseconds: 500),
                          curve: Curves.easeIn
                      );

                    },
                    child: Text('Next',
                      style: TextStyle(
                        fontSize: 20,
                      ),)
                ),
              ],
            ),
          )
        ]
      ),
    );
  }
}
