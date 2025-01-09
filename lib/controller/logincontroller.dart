import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sample/utils/apputils.dart';

class Logincontroller with ChangeNotifier{
bool isloading = false;

  Future<void> onLogin({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
isloading = true;
notifyListeners();
    try {
  final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: email,
    password: password,
   
  );
  
  log(credential.user?.email.toString()??"no data");
  Apputils.showOnetimeSnackbar(context: context,bg: Colors.green, message:"Login Successfull");

} on FirebaseAuthException catch (e) {
   log(e.code.toString());
  if (e.code == 'invalid-email') {
   Apputils.showOnetimeSnackbar(context: context,message: "No user found for that email.");
    
  } else if (e.code == 'invalid-credential') {
  
    Apputils.showOnetimeSnackbar(context: context,message: "Wrong password provided for that user.");
  }
}
isloading = false;
notifyListeners();
  }
}