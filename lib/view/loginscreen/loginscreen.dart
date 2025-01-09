import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample/controller/logincontroller.dart';
import 'package:sample/view/homscreen/homscreen.dart';

import 'package:sample/view/registrationscreen/registrationscreen.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  TextEditingController emailcontroller=TextEditingController();
  TextEditingController passwordcontroller=TextEditingController();
  final _formkey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return 
     
      StreamBuilder(stream:FirebaseAuth.instance.authStateChanges(

      ) , builder: (context, snapshot) {
        if(snapshot.hasData){
          return Homscreen();
        }else{
return Scaffold(
appBar: AppBar(
  title: Text("Login",style: TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.bold
  ),),
),
  body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Consumer<Logincontroller>(
            builder: (context, Logincontrollerr, child) =>
             Form(
              key: _formkey,
               child: Column(
                         
                spacing: 16,
                children: [
                         
                         
                  TextFormField(
                    controller:emailcontroller,
                    decoration: InputDecoration(
                      label: Text("email"),
                      enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black,width: 2),
                            borderRadius: BorderRadius.circular(15),
                         
                      ),
                      focusedBorder: OutlineInputBorder(
                         borderSide: BorderSide(color: Colors.black,width: 2),
                            borderRadius: BorderRadius.circular(15),
                      ),
                      errorBorder: OutlineInputBorder(),
                      focusedErrorBorder: OutlineInputBorder(),
                    ),
                     validator: (value) {
                          if( value==null ||value.isEmpty ){
                            return "enter your username";
                          }
                          return null;
                     }
                  ),
                         
                         
                     TextFormField(
                      controller: passwordcontroller,
                    decoration: InputDecoration(
                      label: Text("password"),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black,width: 2),
                                borderRadius: BorderRadius.circular(15),
                         
                      ),
                      focusedBorder: OutlineInputBorder(
                         borderSide: BorderSide(color: Colors.black,width: 2),
                            borderRadius: BorderRadius.circular(15),
                      ),
                      errorBorder: OutlineInputBorder(),
                      focusedErrorBorder: OutlineInputBorder(),
                    ),
                    validator: (value) {
                    if (value == null || value.isEmpty) {
                    return "Enter your password";
                       } else if (value.length < 6) {
                        return "Password must contain at least 6 characters";
                       }
                    return null;
                        }
  
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                      InkWell(
                        onTap: () {
                          Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => Registrationscreen(),));
                        },
                        child: Container(
                        padding: EdgeInsets.all(10),
                        child: Text("Registeration",style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.black,
                              
                        ),
                                      ),
                      ),
                    Logincontrollerr.isloading?Center(child: CircularProgressIndicator(),):
                    InkWell(
                      onTap: () {     
                           if(_formkey.currentState!.validate()) {        
                            Logincontrollerr.onLogin(email: emailcontroller.text, password: passwordcontroller.text, context: context);    
                      }
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Text("Login",style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.black,
                              
                        ),
                      ),
                    ),
                  ],
                ),
                
                ],
                         ),
             ),
          ),
        ),
);
        }
      },);
    
  }
}