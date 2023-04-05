import 'package:assesment/FirstCard.dart';
import 'package:assesment/SecCard.dart';
import 'package:flutter/material.dart';
import 'package:swipeable_button_view/swipeable_button_view.dart';

import 'CoustomCard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int height =180;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
     body: SafeArea(
       child: Stack(
         children: [
           Center(
             child: Column(
               children: [
                 Row(
                   mainAxisAlignment: MainAxisAlignment.start,
                   children: [
                     SizedBox(
                       width: 30,
                     ),
                     Icon(
                       Icons.arrow_back_ios,
                       color: Colors.white,
                     ),
                   ],
                 ),
               Text('Swap ETH',
                 style: TextStyle(
                   color: Colors.white,
                   fontSize: 19,
                   fontWeight: FontWeight.bold
                 ),
               ),
                 SizedBox(
                   height: 15,
                 ),
                 Text('Ethereum Mainnet',
                 style: TextStyle(
                   color: Colors.white,
                 ),
                 ),
                 SizedBox(
                   height: 50,
                 ),
                 CoustomCard(
                   colur: Colors.blueGrey.shade800,
                   chil:  Padding(
                     padding: const EdgeInsets.all(1.0),
                     child: FirstCard(),
                   ),
                 ),
                 SizedBox(
                   height: 10,
                 ),
                 SecCard(),
                 SizedBox(
                   height: 50,
                 ),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                   children: [
                     Text('SLIPAGE',
                     style: TextStyle(
                       color: Colors.white
                     ),
                     ),
                     Text('DETAILS',
                       style: TextStyle(
                           color: Colors.white
                       ),
                     )
                   ],
                 ),
                 SizedBox(height: 10,),
                 CoustomCard(
                     colur: Colors.white12,
                     chil: SliderTheme(
                       data: SliderThemeData(
                         thumbShape: RoundSliderThumbShape(
                           enabledThumbRadius: 13,
                         ),
                         overlayShape: RoundSliderOverlayShape(
                           overlayRadius: 35,
                         ),
                         thumbColor: Colors.blue,
                         activeTrackColor: Colors.blue,
                         overlayColor: Color(0x29EB1555),
                         inactiveTrackColor: Color(0XFF8D8E98),
                       ),
                       child: Slider(
                         value: height.toDouble(),
                         max: 220,
                         min: 180,
                         onChanged: (double newVal){
                           setState(() {
                             height = newVal.round();
                           });


                         },
                       ),
                     ),
                 ),
                 SizedBox(height: 20,),
                 Padding(
                   padding: const EdgeInsets.all(30.0),
                   child: Container(
                     padding: EdgeInsets.all(3.0),
                     decoration: BoxDecoration(
                       color: Colors.blueGrey.shade800,
                       borderRadius: BorderRadius.circular(80)

                     ),
                     child: SwipeableButtonView(
                         onFinish: (){},
                         onWaitingProcess: (){},
                         activeColor: Colors.black,
                         buttonWidget: Container(
                           child: Icon(
                             Icons.check,
                           ),
                         ),
                         buttonText: 'SWIPE TO PAY'
                     ),
                   ),
                 )

               ],
             ),
           ),
           Row(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               SizedBox(
                 height: 480,
               ),
               CircleAvatar(
                 backgroundColor: Colors.lightBlue.shade400,
                 radius: 20,
                 child: Icon(
                   Icons.swap_vert_outlined,
                   color: Colors.black,
                   size: 28,
                 ),
               )
             ],
           )

         ],
       ),
     ),

    );
  }
}

