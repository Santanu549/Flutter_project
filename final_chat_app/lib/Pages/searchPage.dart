
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_chat_app/Models/ChatRoomModel.dart';
import 'package:final_chat_app/Models/UserModel.dart';
import 'package:final_chat_app/Pages/chatRoomPage.dart';
import 'package:final_chat_app/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';



class searchPage extends StatefulWidget {
  final UserModel ModelUser;
  final User FirebaserUser;

  const searchPage({super.key, required this.ModelUser, required this.FirebaserUser});





  @override
  State<searchPage> createState() => _searchPageState();
}

class _searchPageState extends State<searchPage> {
  TextEditingController searchController = TextEditingController();
  ChatRoomModel? chatRoom;



  Future<ChatRoomModel?> getChatroomModel(UserModel targetUser) async {
    QuerySnapshot snapShot =  await FirebaseFirestore.instance.collection("chatroom").where("Perti.${widget.ModelUser.uid}", isEqualTo: true).where
      ("Perti.${targetUser.uid}", isEqualTo: true).get();
    if(snapShot.docs.length > 0){
      var chatData  = snapShot.docs[0].data();
      ChatRoomModel existingModel = ChatRoomModel.fromMap(chatData as Map<String, dynamic>);
      chatRoom = existingModel;

      print("chat room already exist");
    }
    else{
      ChatRoomModel newChatRoom = ChatRoomModel(
        chatRoomid: uuid.v1(),
        Perti: {
          widget.ModelUser.uid.toString(): true,
          targetUser.uid.toString(): true,
        },
        lastMassage: "",
      );
      await FirebaseFirestore.instance.collection("chatroom").doc(newChatRoom.chatRoomid).set(newChatRoom.toMap());
      chatRoom = newChatRoom;
      print("New chat Room Created");

    }
    return chatRoom;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Center(
            child: Column(
              children: [
                TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    hintText: "Enter email",
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                CupertinoButton(
                    child: Text("Search"),
                    color: Colors.blue,
                    onPressed: (){
                      setState(() {

                      });
                    }
                ),
                SizedBox(
                  height: 20,
                ),
                StreamBuilder(
                  stream: FirebaseFirestore.instance.collection("User").where(
                      "email", isEqualTo: searchController.text).where("email", isNotEqualTo: widget.ModelUser.email).snapshots(),
                  builder: (context, snapshot){
                    if(snapshot.connectionState == ConnectionState.active){
                      if(snapshot.hasData){
                        QuerySnapshot QData = snapshot.data as QuerySnapshot;
                        if(QData.docs.length > 0){
                          Map<String, dynamic> UserMap = QData.docs[0].data() as Map<String, dynamic>;
                          UserModel serchedUser = UserModel.fromMap(UserMap);
                          return ListTile(
                            onTap: () async {
                              ChatRoomModel? chatroom = await getChatroomModel(serchedUser);
                              if(chatroom != null){
                                Navigator.pop(context);
                                Navigator.push(context, PageTransition(
                                  child: chatRoomPage(
                                    userModel: widget.ModelUser,
                                    targetUser: serchedUser,
                                    firebaseuser: widget.FirebaserUser,
                                    chatRoom: chatroom,
                                  ),
                                  type: PageTransitionType.rightToLeft,
                                )
                                );
                              }
                              else{

                              }

                            },
                            trailing: Icon(Icons.keyboard_arrow_right),
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(serchedUser.profilePic!),
                              backgroundColor: CupertinoColors.inactiveGray,
                            ),
                            title: Text(serchedUser.fullName!),
                            subtitle: Text(serchedUser.email!),
                          );
                        }else{
                          return Text("No result Found!");
                        }



                      }
                      else if(snapshot.hasError){
                        return Text("Eror occurd!");
                      }else{
                        return Text("No result Found!");
                      }
                    }else{
                      return CircularProgressIndicator();
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}