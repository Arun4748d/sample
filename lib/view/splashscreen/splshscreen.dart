import 'package:flutter/material.dart';
import 'package:sample/view/loginscreen/loginscreen.dart';

class Splshscreen extends StatefulWidget {
  const Splshscreen({super.key});

  @override
  State<Splshscreen> createState() => _SplshscreenState();
}

class _SplshscreenState extends State<Splshscreen> {
  @override
  void initState() {
   Future.delayed(Duration(seconds: 3),(){
     Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => Loginscreen()),
      (route) => false,
    );
  });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text("ChatApp",style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),),
          )
        ],
      ),
      
    );
  }
}