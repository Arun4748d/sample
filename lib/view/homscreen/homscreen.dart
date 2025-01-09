import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample/controller/Chatcontroller.dart';
import 'package:sample/view/searchscreen/searchscreen.dart';
import 'package:sample/view/widgets/chat_tile.dart';

class Homscreen extends StatefulWidget {
  const Homscreen({super.key});

  @override
  State<Homscreen> createState() => _HomscreenState();
}

class _HomscreenState extends State<Homscreen> {
    @override
  void initState() {
    // TODO: implement initState
    getcurrentuser();
    super.initState();
  }

  User?loggedInUser;
  void getcurrentuser() {
    final user =FirebaseAuth.instance.currentUser;
    if(user!=null){
      setState(() {
         loggedInUser=user;
      });
    }
  }
  Future<Map<String,dynamic>>fetchchatdata(String chatId)async{
   final chatDoc =await FirebaseFirestore.instance.collection("chats").doc(chatId).get();
   final chatData =chatDoc.data();
   if (chatData == null) return {};
   final users=chatData["users"]as List<dynamic>;
   final receiverId =users.firstWhere((id)=>id!=loggedInUser!.uid);
   final userDoc=await FirebaseFirestore.instance.collection("users").doc
   (receiverId).get();
   final userData=userDoc.data();
    if (userData == null) return {};
   return{
    "chatId":chatId,
    "lastMessage":chatData["lastMessage"]??"",
    "timestamp": chatData["timestamp"]?.toDate() ?? DateTime.now(),

    "userData":userData,
   };
  }
  @override
  Widget build(BuildContext context) {
    final chatprovider =Provider.of<ChatProvider>(context);
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 185, 220, 236),
          title: Text("chats",style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold
          ),),
          actions: [
            IconButton(onPressed: () async {
              await FirebaseAuth.instance.signOut();
            }, icon: Icon(Icons.logout,
            color: Colors.black,))
          ],
        ),
      
        body:Column(
          children: [
            Expanded(child: StreamBuilder<QuerySnapshot>(
              stream:chatprovider.getChats(loggedInUser!.uid) ,
               builder: (context, snapshot) {
                if(!snapshot.hasData){
                  return Center(child: CircularProgressIndicator(),);
                }
                final chatDocs=snapshot.data!.docs;
                return FutureBuilder<List<Map<String, dynamic>>>(
                          future: Future.wait(chatDocs.map((chatDoc) => fetchchatdata(chatDoc.id))),

                  builder: (context, snapshot) {
                         if(!snapshot.hasData){
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                         }
                         final chatDataList=snapshot.data!;
                         return ListView.builder(
                          itemCount: chatDataList.length,
                          itemBuilder: 
                         (context, index) {
                          final chatData=chatDataList[index];
                           return ChatTile(
                            chatId: chatData["chatId"], 
                            lastMessage:chatData["lastMessage"], 
                            timestamp: chatData["timestamp"], 
                            receiverData:chatData["userData"]);
                         },);
                  }
                );
               },))
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          child: Icon(Icons.search_sharp),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => 
            Searchscreen(),));
          },),
      ),
    );
  }
}