import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class ChatProvider with ChangeNotifier{

  Stream<QuerySnapshot> getChats(String userId){
    return FirebaseFirestore.instance
    .collection("chats").where("users",arrayContains: userId).snapshots();
  }

    Stream<QuerySnapshot> searchUser(String query){
    return FirebaseFirestore.instance
    .collection("users")
    .where("email",isGreaterThanOrEqualTo: query).
    where("email",isLessThanOrEqualTo: query + '\uf8ff').snapshots();
  }

Future<void>sendmessage( String chatId,String message,String receiverId) async {
final currentuser=FirebaseAuth.instance.currentUser;
if(currentuser!=null){
await FirebaseFirestore.instance.collection("chats").doc(chatId).collection('messages').add({
  'senderId':currentuser.uid,
  'receverID':receiverId,
   'messageBody':message,
   'timestamp':FieldValue.serverTimestamp(),
   
});
await FirebaseFirestore.instance.collection("chats").doc(chatId).set({
  'users':[currentuser.uid,receiverId],
  'lastMessage':message,
  'timestamp':FieldValue.serverTimestamp(),
},SetOptions(merge: true)
);

}
}

Future<String?>getChatsroom(String receiverId)async{
  final currentuser=FirebaseAuth.instance.currentUser;

  if(currentuser!=null){
    final chatQuery=await  FirebaseFirestore.instance.collection('chats').where(
      'users',arrayContains: currentuser.uid
    ).get();
    final chats=chatQuery.docs.where((chat)=>chat['users'].contains(receiverId)).toList();
    if(chats.isNotEmpty){
      return chats.first.id;
    }
  }
  return null;
}


Future<String>createchatRoom(String receiverId)async{
  final currentuser=FirebaseAuth.instance.currentUser;

  if(currentuser!=null){
    final chatroom =await FirebaseFirestore.instance.collection("chats").add({
      "user":[currentuser.uid, receiverId],
      'lastmessage':'',
      'timestamp':FieldValue.serverTimestamp(),
    }
    );
    return chatroom.id;
  }
  throw Exception('current user is null');
}
}