
import 'package:cloud_firestore/cloud_firestore.dart';

import 'UserModel.dart';

class FirebaseHelper{
  static Future<UserModel?> getUserModel_by_id(String uid) async{
    UserModel? userModel;
    DocumentSnapshot docSnap = await FirebaseFirestore.instance.collection("User").doc(uid).get();
    if(docSnap != null){
      userModel = UserModel.fromMap(docSnap.data() as Map<String, dynamic>);
    }
    return userModel;

  }

}