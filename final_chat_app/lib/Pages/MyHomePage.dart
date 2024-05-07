
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_chat_app/Models/ChatRoomModel.dart';
import 'package:final_chat_app/Models/FirebaseHelper.dart';
import 'package:final_chat_app/Models/UserModel.dart';
import 'package:final_chat_app/Pages/chatRoomPage.dart';
import 'package:final_chat_app/Pages/logInPage.dart';
import 'package:final_chat_app/Pages/searchPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class MyHomePage extends StatefulWidget {
  final UserModel userModel;
  final User firebaseuser;

  const MyHomePage({super.key, required this.userModel, required this.firebaseuser});


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amberAccent.shade700,
      appBar: AppBar(
        title: Text("Chat App"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.popUntil(context, (route) => route.isFirst);
              Navigator.pushReplacement(context, PageTransition(
                  duration: Duration(milliseconds: 500),
                  child: LogIn_Page(),
                  type: PageTransitionType.rightToLeft
              ));

            },
            icon: Icon(Icons.logout),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, PageTransition(
            child: searchPage(
              ModelUser: widget.userModel,
              FirebaserUser: widget.firebaseuser,
            ),
            type: PageTransitionType.rightToLeft,
          )
          );

        },
        child: Icon(Icons.search_rounded),
      ),
      body: Container(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("chatroom").where("Perti.${widget.userModel.uid}", isEqualTo: true)
              .snapshots(),
          builder: (context, snapshot){
            if(snapshot.connectionState == ConnectionState.active){
              QuerySnapshot chatRoomSnap = snapshot.data as QuerySnapshot;
              if(snapshot.hasData){
                return ListView.builder(

                    itemCount: chatRoomSnap.docs.length,
                    itemBuilder: (context, index){
                      ChatRoomModel chatRoommodel = ChatRoomModel.fromMap(chatRoomSnap.docs[index].data() as Map<String, dynamic>);

                      Map<String, dynamic> perticipants = chatRoommodel.Perti!;

                      List<String> perticipantsKeys = perticipants.keys.toList();

                      perticipantsKeys.remove(widget.userModel.uid);
                      return FutureBuilder(
                        future: FirebaseHelper.getUserModel_by_id(perticipantsKeys[0]),
                        builder: (context, userData) {

                          if(userData.connectionState == ConnectionState.done){
                            if(userData.data != null){
                              UserModel targetUser = userData.data as UserModel;
                              return Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(50)
                                    ),
                                    child: ListTile(
                                      onTap: (){
                                        Navigator.push(context, PageTransition(
                                            duration: Duration(milliseconds: 500),
                                            child: chatRoomPage(
                                              targetUser: targetUser,
                                              userModel: widget.userModel,
                                              chatRoom: chatRoommodel,
                                              firebaseuser: widget.firebaseuser,
                                            ),
                                            type: PageTransitionType.rightToLeft

                                        )
                                        );
                                      },
                                      leading: CircleAvatar(
                                        backgroundImage: NetworkImage(targetUser.profilePic.toString()),
                                      ),
                                      title: Text(targetUser.fullName.toString()),
                                      subtitle: (chatRoommodel.lastMassage.toString() != "") ? Text(chatRoommodel.lastMassage.toString()) :
                                      Text("Say hi to Your New friend",
                                        style: TextStyle(
                                          color: Colors.blue,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }
                            else{
                              return Container();
                            }

                          }else{
                            return Container();
                          }

                        },
                      );

                    }
                );

              }
              else if(snapshot.hasError){
                return Text(snapshot.hasError.toString());
              }else{
                return Text("No Friend Found go to Seach Page");
              }
            }
            else{
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}