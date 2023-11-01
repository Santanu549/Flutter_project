

import 'package:flutter/material.dart';

class UIHelper{
  static void showLoading(String title, BuildContext context){
    AlertDialog loadingDialog = AlertDialog(
      content: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 10),
            Text(title)
          ],
        ),
      ),
    );
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context){
          return loadingDialog;

        }
    );

  }



  static void showAlertDialuge(String title, String content, BuildContext context){
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(onPressed: (){
          Navigator.pop(context);
        }, child: Text("OK"))
      ],


    );

    showDialog(context: context, builder: (context){
      return alertDialog;
    });

  }



}