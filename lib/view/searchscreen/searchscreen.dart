import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample/controller/Chatcontroller.dart';
import 'package:sample/view/chatScreen/chatscreen.dart';

class Searchscreen extends StatefulWidget {
  const Searchscreen({super.key});

  @override
  State<Searchscreen> createState() => _SearchscreenState();
}

class _SearchscreenState extends State<Searchscreen> {
      @override
  void initState() {
    // TODO: implement initState
    getcurrentuser();
    super.initState();
  }

  User?loggedInUser;
  String searchQueary="";
  void getcurrentuser() {
    final user =FirebaseAuth.instance.currentUser;
    if(user!=null){
      setState(() {
         loggedInUser=user;
      });
    }
  }
  void handleSearch(String query){
    setState(() {
      searchQueary=query;
    });
  }
  @override
  Widget build(BuildContext context) {
    final chatprovider=Provider.of<ChatProvider>(context);
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text("Search",style: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),),
       
        ),
        body: Column(
          children: [
            Padding(padding: EdgeInsets.all(8),
            child: TextField(
              decoration: InputDecoration(
                hintText: "search user",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),

              ),
              onChanged: handleSearch,
            ),),
            Expanded(child: 
            StreamBuilder<QuerySnapshot>(stream:searchQueary.isEmpty?FirebaseFirestore.instance.collection("users").snapshots():
            chatprovider.searchUser(searchQueary) , 
            builder: (context, snapshot) {
              if(!snapshot.hasData){
                return Center(
                  child: CircularProgressIndicator(),
                );

              }
              final users =snapshot.data!.docs;
              List<UserTile>userWidgets=[];
              for(var user in users){
                final userData=user.data() as Map<String,dynamic>;
                if(userData["uid"]!=loggedInUser!.uid){
                  final userWidget=UserTile(
                    userId: userData["uid"],
                     name: userData["name"],
                      email: userData["email"], 
                      receiverData: userData,
                      );
                      userWidgets.add(userWidget);
                }
              }
              return ListView(
                children: userWidgets,
              );
            },))
          ],
        ),
    );
  }
}

class UserTile extends StatelessWidget {
  final String userId;
  final String name;
   final String email;
      final Map<String,dynamic>receiverData;

  const UserTile({super.key, required this.userId, required this.name, required this.email,required this.receiverData});
    // final String imageUrl,
   
  @override
  Widget build(BuildContext context) {
    final chatProvider=Provider.of<ChatProvider>(context,listen: false);
    return ListTile(
      leading: CircleAvatar(
        radius: 25,
        backgroundColor: const Color.fromARGB(255, 185, 220, 236),
        child: Text(receiverData["name"].substring(0, 1).toUpperCase(),style: TextStyle(
          color: Colors.black
        ),),
      ),
      title: Text(name,style: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),),
      subtitle: Text(email),
      onTap: () async {
        final chatId =await chatProvider.getChatsroom(userId)?? await chatProvider.
        createchatRoom(userId);
          Navigator.push(context, MaterialPageRoute(builder:(context)=>ChatScreen(
        chatId: chatId, receiverid: userId,)));
      },
    
    );
  }
}