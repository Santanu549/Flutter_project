import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Welcome To The Home Page',
          style: TextStyle(
            fontSize: 25,
          ),

        ),
      ),
      bottomNavigationBar: GNav(
        backgroundColor: Colors.black,
        color: Colors.white,
        activeColor:Colors.white,
        tabBackgroundColor: Colors.grey.shade800,
        padding: EdgeInsets.all(16),
        gap: 8,
        tabs: const [
          GButton(icon: Icons.home,
            text: 'Home',
          ),
          GButton(icon: Icons.favorite,
          text: 'Like',
          ),
          GButton(icon: Icons.search,
          text: 'Search',
          ),
          GButton(icon: Icons.settings,
          text: 'Setting',
          ),
        ],
      )
    );
  }
}
