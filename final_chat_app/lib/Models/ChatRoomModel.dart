import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class ChatRoomModel{
  String? chatRoomid;
  Map<String, dynamic>? Perti;
  String? lastMassage;
  DateTime? DATE;

  ChatRoomModel({this.chatRoomid, this.Perti, this.lastMassage});

  ChatRoomModel.fromMap(Map<String, dynamic> map){
    chatRoomid = map["chatRoomid"];
    Perti = map["Perti"];
    lastMassage = map["lastMassage"];

  }
  Map<String, dynamic> toMap(){
    return {
      "chatRoomid":chatRoomid,
      "Perti":Perti,
      "lastMassage": lastMassage,

    };
  }

}