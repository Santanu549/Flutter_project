import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import 'Models/FirebaseHelper.dart';
import 'Models/UserModel.dart';
import 'Pages/MyHomePage.dart';
import 'Pages/logInPage.dart';

var uuid = Uuid();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  User? currentUser = FirebaseAuth.instance.currentUser;
  if(currentUser != null){
    UserModel? newUserModel = await FirebaseHelper.getUserModel_by_id(currentUser.uid);
    if(newUserModel!=null){
      runApp(
          MyAppLoggedIn(
            userModel: newUserModel,
            firebaseUser: currentUser,
          )
      );
    }else{
      runApp(MyApp());
    }

  }else{
    runApp(MyApp());
  }

}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LogIn_Page(),
    );
  }
}


class MyAppLoggedIn extends StatelessWidget {

  final UserModel userModel;
  final User firebaseUser;

  const MyAppLoggedIn({super.key, required this.userModel, required this.firebaseUser});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(
        userModel: userModel,
        firebaseuser: firebaseUser,
      ),
    );
  }
}


