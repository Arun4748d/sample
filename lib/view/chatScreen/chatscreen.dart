import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sample/controller/Chatcontroller.dart';

import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  final String ?chatId;
  final String receiverid;

  const ChatScreen({super.key,required this.chatId,required this.receiverid});
  

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
    @override
  void initState() {
    // TODO: implement initState
    getcurrentuser();
    chatId =widget.chatId;
    super.initState();
  }

  User?loggedInUser;
  String?chatId;
  void getcurrentuser() {
    final user =FirebaseAuth.instance.currentUser;
    if(user!=null){
      setState(() {
         loggedInUser=user;
      });
    }
  }

  final messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    // final chatProvider= Provider.of<Chatcontroller>(context);
    // final TextEditingController textcontroller=TextEditingController();
   final textcontroller = messageController;
 
    return FutureBuilder<DocumentSnapshot>(future:FirebaseFirestore.instance.collection("users") .
    doc(widget.receiverid).get(),
     builder: (context, snapshot) {
       
       if(snapshot.connectionState ==ConnectionState.done){
        final receiverData =snapshot.data!.data() as Map<String,dynamic>;
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 185, 220, 236),
            title: Row(
              children: [
               CircleAvatar(
        radius: 25,
        backgroundColor: const Color.fromARGB(255, 241, 238, 238),
        child: Text(receiverData["name"].substring(0, 1).toUpperCase(),style: TextStyle(
          color: Colors.black
        ),),
      ),
                SizedBox(width: 10,),
                Text(receiverData["name"],style: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),)
              ],
            ),
          ),
          body: Consumer<ChatProvider>(
            builder: (context, value, child) => 
             Column(
              children: [
                Expanded(child: chatId!=null && chatId!.isNotEmpty?meassageStream(chatId: chatId!)
                :Center(
                  child: Text("No Message"),
                )),
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 15,vertical: 8),
                  child: Row(
                    children: [
                      Expanded(child: TextFormField(
                        controller: textcontroller,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter your Message",
                        ),
                      )),
                      IconButton(onPressed: () async {
                        if(textcontroller.text.isNotEmpty){
                          if(chatId ==null || chatId!.isEmpty){
                            chatId =await value.createchatRoom(widget.receiverid);
                          }
                          if(chatId!=null){
                            value.sendmessage(chatId!,
                            textcontroller.text,widget. receiverid);
                            textcontroller.clear();
                          }
                        }
                      }, icon: Icon(Icons.send,color: Colors.blueAccent,)),
                      
                    ],
                  ),
                )
              ],
            ),
          ),
        );
       }
       return Scaffold(
        appBar: AppBar(),
        body: Center(child: CircularProgressIndicator(),),
       );
     },);
  }
}

class meassageStream extends StatefulWidget {
final String chatId;

  const meassageStream({super.key, required this.chatId});

  @override
  State<meassageStream> createState() => _meassageStreamState();
}

class _meassageStreamState extends State<meassageStream> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream:FirebaseFirestore.instance.collection("chats").doc(widget.chatId).collection("messages").orderBy
      ("timestamp",descending: true).snapshots() ,
     builder: (context, snapshot) {
       if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
  return Center(
    child: Text("No messages yet"),
  );
}

       final messages =snapshot.data!.docs;
       List<MessageBubble>messagewidgets=[];
       for(var message in messages){
        final messageData =message.data() as Map<String ,dynamic>;
        final messageText =messageData["messageBody"];
        final messageSender =messageData["senderId"];
final timestamp = messageData["timestamp"] ?? Timestamp.now();

        // final messageTimestamp = messageData["timestamp"] ?? Timestamp.now();


        final currentuser =FirebaseAuth.instance.currentUser!.uid;
        final messageWidget = MessageBubble(
          sender: messageSender,
           text: messageText,
            isME: currentuser==messageSender,
            timestamp:timestamp,);
            messagewidgets.add(messageWidget);
            
       }
       return ListView(
        reverse: true,
        children: messagewidgets,
       );
     },);
  }


}

class MessageBubble extends StatelessWidget {
  final String sender;
  final String text;
  final bool isME;
  final dynamic timestamp;

  const MessageBubble({super.key, required this.sender, required this.text, required this.isME, this.timestamp});

  @override
  Widget build(BuildContext context) {
    final DateTime messageTime = (timestamp is Timestamp)?timestamp.toDate()
    :DateTime.now();
    return Padding(padding: 
    EdgeInsets.all(10),
    child: Column(
      crossAxisAlignment:isME?
      CrossAxisAlignment.end:CrossAxisAlignment.start,
      children: [
         Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width*0.75,
          ),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                spreadRadius: 2,
                blurRadius: 4,
              ),
              
            ],
            borderRadius: isME?BorderRadius.only(
              topLeft: Radius.circular(15),
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15)
            ):BorderRadius.only(
              topRight: Radius.circular(15),
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
            color: isME?const Color.fromARGB(255, 164, 161, 161):const Color.fromARGB(255, 65, 104, 123),
          ),
          child: Padding(padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(text,style: 
              TextStyle(
                color: isME?Colors.white:Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),),
              SizedBox(height: 5,),
              Text(
                "${messageTime.hour}:${messageTime.minute}",
                style: TextStyle(
                  color: isME?Colors.white:Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold
                ),
              )
            ],
          ),),
         )
      ],
    ),);
  }
}
