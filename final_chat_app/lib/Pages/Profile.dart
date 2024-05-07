import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_chat_app/Models/UIHelper.dart';
import 'package:final_chat_app/Models/UserModel.dart';
import 'package:final_chat_app/Pages/MyHomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';



class Complete_profile extends StatefulWidget {
  final UserModel userModel;
  final User FibaseUser;

  const Complete_profile({super.key, required this.userModel, required this.FibaseUser});




  @override
  State<Complete_profile> createState() => _Complete_profileState();
}

class _Complete_profileState extends State<Complete_profile> {
  File? imageFile;
  TextEditingController fullNameController = TextEditingController();
  void selectImage(ImageSource source) async {
    XFile? PickedFile = await ImagePicker().pickImage(source: source);
    if(PickedFile != null){
      crropImage(PickedFile);
    }
  }
  void crropImage(XFile file) async {
    var cropIMAGE = await ImageCropper().cropImage(
      sourcePath: file.path,
      aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
      compressQuality: 20,
    );
    if(cropIMAGE != null){
      setState(() {
        imageFile = File(cropIMAGE.path);
      });
    }


  }

  void showPhotoOption(){
    showDialog(context: context, builder: (context)
    {
      return AlertDialog(
        title: Text("Upload Picture"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              onTap: (){
                Navigator.pop(context);
                selectImage(ImageSource.gallery);
              },
              leading: Icon(Icons.photo),
              title: Text("Select from galary"),
            ),
            ListTile(
              onTap: (){
                Navigator.pop(context);
                selectImage(ImageSource.camera);
              },
              leading: Icon(Icons.camera_alt),
              title: Text("Take a photo"),
            ),
          ],
        ),
      );
    });
  }

  void checkValues(){
    String fullName = fullNameController.text.trim();
    if(fullName=="" || imageFile==null){
      UIHelper.showAlertDialuge("Incomplete data", "please fill all the fields", context);

    }
    else{
      uploadData();
    }
  }
  void uploadData() async {

    UIHelper.showLoading("Uploading image....", context);
    UploadTask uploadTask = FirebaseStorage.instance.ref("ProfilePic").child(widget.userModel.uid.toString()).putFile(imageFile!);
    TaskSnapshot snapshot = await uploadTask;
    String imageUrl = await snapshot.ref.getDownloadURL();
    String fullName = fullNameController.text.trim();
    widget.userModel.fullName = fullName;
    widget.userModel.profilePic=imageUrl;
    await FirebaseFirestore.instance.collection("User").doc(widget.userModel.uid).set(widget.userModel.toMap()).then((value) {
      Navigator.popUntil(context, (route) => route.isFirst);
      Navigator.pushReplacement(context, PageTransition(
          child: MyHomePage(
            userModel: widget.userModel,
            firebaseuser: widget.FibaseUser,
          ),
          type: PageTransitionType.rightToLeft
      ));
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          "Complete Profile",
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: ListView(
            children: [
              SizedBox(
                height: 20,
              ),
              CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: (){
                  showPhotoOption();
                },
                child: CircleAvatar(
                  backgroundImage: (imageFile != null) ? FileImage(imageFile!) : null,
                  radius: 60,
                  child: (imageFile == null) ? Icon(
                    Icons.person,
                    size: 60,
                  ) : null,
                ),
              ),
              SizedBox(height: 20,),
              TextField(
                controller: fullNameController,
                decoration: InputDecoration(
                    labelText: "Full Name"
                ),
              ),
              SizedBox(
                height: 20,
              ),
              CupertinoButton(
                  color: Theme.of(context).colorScheme.secondary,
                  child: Text("Submit",),
                  onPressed: (){
                    checkValues();
                  }
              )
            ],
          ),

        ),
      ),
    );
  }
}