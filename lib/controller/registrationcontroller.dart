

import 'dart:developer';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'package:sample/utils/apputils.dart';

class Registrationcontroller with ChangeNotifier{
  //  File?_image;
  bool isloading = false;

//  File? get image => _image;

  Future<void> onregistration({
    required String email,
       required String name,
    required  String password,
        
    required BuildContext context,
  }) async {
  //    if (_image == null) {
  //   Apputils.showOnetimeSnackbar(context: context, message: "Please pick an image.");
  //   return;
  // }
    isloading = true;
    notifyListeners();
    try {
  UserCredential credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: email,
    
    password: password,
    
  );
  // final imageUrl=await _uploadimage(_image!);
  await FirebaseFirestore.instance.collection('users').doc(credential.user!.uid).set({
    'uid':credential.user!.uid,
    'name':name,
    'email':email,
    'password':password,
    // 'imageUrl':imageUrl,
  });
  if(credential.user?.uid!=null){
     Apputils.showOnetimeSnackbar(context: context,
     bg: Colors.green,
      message: "Registration successful");
  }
  log(credential.user?.uid.toString()??"nodata");
} on FirebaseAuthException catch (e) {
  if (e.code == 'weak-password') {

    Apputils.showOnetimeSnackbar(context: context, message: "The password provided is too weak.");
  } else if (e.code == 'email-already-in-use') {

    Apputils.showOnetimeSnackbar(context: context, message: "The account already exists for that email.");
  }
} catch (e) {
  print(e);
   Apputils.showOnetimeSnackbar(context: context, message: e.toString());
}
isloading = false;
notifyListeners();
  }


  // Future<String>_uploadimage(File image)async{
  //   final ref=FirebaseStorage.instance.ref().child('user_images').
  //   child('${FirebaseAuth.instance.currentUser!.uid}.jpg');
  //   await ref.putFile(image);
  //   return await ref.getDownloadURL();
    

  //  }

  //     Future<void>pickimage()async{
  //   final pickedFile= await ImagePicker().pickImage(source: ImageSource.gallery);
    
  //     if(pickedFile !=null){
  //       _image=File(pickedFile.path);
  //       notifyListeners();
  //     }
    
  //  }
   
}