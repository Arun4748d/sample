import 'package:flutter/material.dart';

class Apputils {
 static showOnetimeSnackbar({required BuildContext context,required String message, Color bg=Colors.red}){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor:bg ,
      content: Text(message)));
  }
}