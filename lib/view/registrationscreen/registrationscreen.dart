
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:sample/controller/registrationcontroller.dart';
import 'package:sample/view/loginscreen/loginscreen.dart';



class Registrationscreen extends StatefulWidget {
  const Registrationscreen({super.key});

  @override
  State<Registrationscreen> createState() => _RegistrationscreenState();
}

class _RegistrationscreenState extends State<Registrationscreen> {
    TextEditingController emaicontroller=TextEditingController();
  TextEditingController passwordcontroller=TextEditingController();
   TextEditingController namecontroller=TextEditingController();
  


   final _formkey=GlobalKey<FormState>();
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registration",style: TextStyle(
          color:Colors.black,
          fontWeight: FontWeight.bold
        ),),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Form(
          key:_formkey ,
          child: Consumer<Registrationcontroller>(
            builder: (context, Registrationcontroller, child) => 
           Column(
              spacing: 16,
              children: [
                  // InkWell(
                  //   onTap: () async {
                  //   await  Registrationcontroller.pickimage();
                  //   },
                  //   child: Container(
                  //     height: 200,
                  //     width: 200,
                  //     decoration:BoxDecoration(
                  //       shape: BoxShape.circle,
                  //       border: Border.all(),
                        
                  //     ) ,
                  //     child:Registrationcontroller.image==null?Center(child: Icon(Icons.camera_alt_rounded),)
                  //     :ClipRRect(
                  //       borderRadius: BorderRadius.circular(100),
                  //       child: Image.file( Registrationcontroller.image!,
                  //       fit: BoxFit.fill,),
                        
                  //     )
                  //   )
                  // ),

                TextFormField(
                    controller: namecontroller,
                    decoration: InputDecoration(
                      label: Text("name"),
                      enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black,width: 2),
                            borderRadius: BorderRadius.circular(15),
              
                      ),
                      focusedBorder: OutlineInputBorder(
                         borderSide: BorderSide(color: Colors.black,width: 2),
                            borderRadius: BorderRadius.circular(15),
                      ),
                      errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red,width: 2),
                            borderRadius: BorderRadius.circular(15),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black,width: 2),
                            borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    validator: (value) {
                      if(value!.isEmpty ){
                        return "please enter your name";
                      }
                      return null;
                    },
                  ),
                 TextFormField(
                    controller: emaicontroller,
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
                      errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red,width: 2),
                            borderRadius: BorderRadius.circular(15),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black,width: 2),
                            borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                     validator: (value) {
                      if( value==null ||value.isEmpty ){
                        return "enter your username";
                      }
                      return null;
                    },
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
                      errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red,width: 2),
                            borderRadius: BorderRadius.circular(15),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black,width: 2),
                            borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                     validator: (value) {
                      if(value==null || value.isEmpty ){
                        return " enter your password";
                      }else if(passwordcontroller.text.length<6){
                      return "password contains atleast 6 characters";
                      }
                      return null;
                    },
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                      InkWell(
                        onTap: () {
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Loginscreen(),),(route) => false,);
                        },
                        child: Container(
                        padding: EdgeInsets.all(10),
                        child: Text("Back",style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.black,
                              
                        ),
                                      ),
                      ),
                      Registrationcontroller.isloading?Center(child: CircularProgressIndicator(),):
                    InkWell(
                      onTap: () {
                        if(_formkey.currentState!.validate()){
                          Registrationcontroller.onregistration(
                            email: emaicontroller.text, 
                            password: passwordcontroller.text,
                            context: context, name: namecontroller.text,  );
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Text("Register",style: TextStyle(
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
}