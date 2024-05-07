
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_chat_app/Models/ChatRoomModel.dart';
import 'package:final_chat_app/Models/MassageModel.dart';
import 'package:final_chat_app/Models/UserModel.dart';
import 'package:final_chat_app/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class chatRoomPage extends StatefulWidget {
  final UserModel targetUser;
  final UserModel userModel;
  final ChatRoomModel chatRoom;
  final User firebaseuser;

  const chatRoomPage({super.key, required this.targetUser, required this.userModel, required this.chatRoom, required this.firebaseuser});



  @override
  State<chatRoomPage> createState() => _chatRoomPageState();
}

class _chatRoomPageState extends State<chatRoomPage> {
  TextEditingController massageContoller = TextEditingController();

  void sendMsg() async {
    String msg = massageContoller.text.trim();
    massageContoller.clear();
    if(msg != ""){
      MassageModel newMassage = MassageModel(
        msgid: uuid.v1(),
        sender: widget.userModel.uid,
        text: msg,
        seen: false,
        DT: DateTime.now(),
      );
      FirebaseFirestore.instance.collection("chatroom").doc(widget.chatRoom.chatRoomid).collection("massages").doc(newMassage.msgid).set
        (newMassage.toMap());

      widget.chatRoom.lastMassage = msg;

      FirebaseFirestore.instance.collection("chatroom").doc(widget.chatRoom.chatRoomid).set(widget.chatRoom.toMap());


    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.grey[300],
              backgroundImage: NetworkImage(widget.targetUser.profilePic.toString()),
            ),
            SizedBox(width: 10,),
            Text(widget.targetUser.fullName.toString())
          ],
        ),
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Expanded(child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: 10
                ),
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance.collection("chatroom").doc(widget.chatRoom.chatRoomid).collection("massages").
                  orderBy("DT", descending: true).snapshots(),
                  builder: (context, snapshot){
                    if(snapshot.connectionState == ConnectionState.active){
                      if(snapshot.hasData){
                        QuerySnapshot dataSnap = snapshot.data as QuerySnapshot;
                        return ListView.builder(
                            reverse: true,
                            itemCount: dataSnap.docs.length,
                            itemBuilder: (context, index){
                              MassageModel currMsg = MassageModel.fromMap(dataSnap.docs[index].data() as Map<String, dynamic>);
                              return Row(
                                mainAxisAlignment: (currMsg.sender == widget.userModel.uid)?
                                MainAxisAlignment.end : MainAxisAlignment.start,
                                children: [
                                  Container(
                                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                      margin: EdgeInsets.symmetric(
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: (currMsg.sender == widget.userModel.uid) ? Colors.grey[600] :
                                        Theme.of(context).colorScheme.secondary,
                                      ),
                                      child: Text(currMsg.text.toString(),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16
                                        ),
                                      )
                                  ),
                                ],
                              );
                            }
                        );

                      }else if(snapshot.hasError){
                        return Text("Check your internet Connection");
                      }else{
                        return Text("Say Hi to your Friend");
                      }

                    }else{
                      return CircularProgressIndicator();
                    }
                  },
                ),
              )),
              Container(
                  color: Colors.grey[200],
                  padding: EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 5
                  ),
                  child: Row(
                    children: [
                      Flexible(
                          child: TextField(
                            maxLines: null,
                            controller: massageContoller,
                            decoration: InputDecoration(
                                hintText: "Enter massage",
                                border: InputBorder.none
                            ),
                          )
                      ),
                      IconButton(onPressed: (){
                        sendMsg();
                      },
                          icon: Icon(Icons.send, color: Colors.blue,))
                    ],
                  )
              )
            ],
          ),
        ),
      ),
    );
  }
}
