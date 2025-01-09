
import 'package:flutter/material.dart';
import 'package:sample/view/chatScreen/chatscreen.dart';

class ChatTile extends StatelessWidget {
   final String chatId;
   final String lastMessage;
   final DateTime timestamp;
   final Map<String,dynamic>receiverData;

  const ChatTile({
    super.key, required this.chatId, required this.lastMessage, required this.timestamp, required this.receiverData});
   


  @override
  Widget build(BuildContext context) {
    return lastMessage !=""?ListTile(
      leading: CircleAvatar(
        radius: 25,
        backgroundColor: const Color.fromARGB(255, 185, 220, 236),
        child: Text(receiverData["name"].substring(0, 1).toUpperCase(),style: TextStyle(
          color: Colors.black
        ),),
      ),
      title: Text(receiverData["name"],style: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),),
      subtitle: Text(lastMessage,maxLines: 2,),
      trailing: Text("${timestamp.hour}:${timestamp.minute},",
      style: TextStyle(
        fontSize: 12,
        color: Colors.black,
      ),
      ),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: 
        (context) => ChatScreen(chatId: chatId, receiverid:receiverData["uid"],),));
      },
    ):Container();
  }
}