import 'package:cloud_firestore/cloud_firestore.dart';

class MassageModel{
  String? msgid;
  String? sender;
  String? text;
  bool? seen;
  DateTime? DT;
  MassageModel({this.text, this.DT, this.seen, this.sender, this.msgid});

  MassageModel.fromMap(Map<String, dynamic> map){
    sender = map["sender"];
    text = map["text"];
    seen = map["seen"];
    Timestamp DaT = map["DT"];
    msgid = map["msgid"];
  }

  Map<String, dynamic> toMap(){
    return{
      "sender": sender,
      "text": text,
      "seen": seen,
      "DT": DT,
      "msgid": msgid,
    };
  }


}