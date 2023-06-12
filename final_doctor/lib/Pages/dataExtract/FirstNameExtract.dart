import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class nameExtract extends StatelessWidget {
  final String DocumentId;
   nameExtract({
    required this.DocumentId
});
  @override
  Widget build(BuildContext context) {

    CollectionReference user=FirebaseFirestore.instance.collection("Details");


    return FutureBuilder<DocumentSnapshot>(
      future: user.doc(DocumentId).get(),
        builder: ((context, snapshot){
          if(snapshot.connectionState==ConnectionState.done){
            Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
            return Text('First Name : ${data['Fname']}');
          }
          return Text("Loading...");
        }),
    );
  }
}
