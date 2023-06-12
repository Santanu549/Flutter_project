import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_doctor/Pages/dataExtract/FirstNameExtract.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final _fireStore = FirebaseFirestore.instance;
  List<String>docId=[];



  Future massageStream() async {
    await _fireStore.collection("Details").get().then(
            (snapshot) => snapshot.docs.forEach((element) {
          docId.add(element.reference.id);
        })
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.amber,
        child: Expanded(
          child: FutureBuilder(
            future: massageStream(),
            builder: (context, index){
              return ListView.builder(
                  itemCount: docId.length,
                  itemBuilder: (context, index){
                    return ListTile(
                      title: nameExtract(

                        DocumentId: docId[index],
                      ),
                    );
                  }
              );
            },
          ),
        ),
      ),
    );
  }
}
