import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
class ChatPage extends StatefulWidget {
  String recieverId;
  String recieverEmail;
  ChatPage({required this.recieverEmail,required this.recieverId});
  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  FocusNode focusNode=FocusNode();
  FirebaseAuth auth=FirebaseAuth.instance;
  FirebaseFirestore firestore=FirebaseFirestore.instance;
  TextEditingController message=TextEditingController();
  sendMessage(String message)async{
    this.message.clear();
    List<String> ids=[this.widget.recieverId,auth.currentUser!.uid];
    ids.sort();
    //A unique chat room id for two users
    String chatRoomid=ids.join("_");
    await firestore.collection("Chat_Rooms").doc(chatRoomid).collection("messages").add({
      "timestamp":Timestamp.now(),
      "recieverid":this.widget.recieverId,
      "senderid":auth.currentUser!.uid,
      "message":message
    });
  }
  ScrollController src=ScrollController();
  Stream<QuerySnapshot> getMessages(){
    List<String> ids=[this.widget.recieverId,auth.currentUser!.uid];
    ids.sort();
    //A unique chat room id for two users
    String chatRoomid=ids.join("_");
    return firestore.collection("Chat_Rooms").doc(chatRoomid).collection("messages")
        .orderBy("timestamp",descending: false).snapshots();
  }
  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    return Scaffold(
       resizeToAvoidBottomInset: true,
      backgroundColor: Colors.indigo.shade100,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white
        ),
        centerTitle: true,
        title: Text(this.widget.recieverEmail,style: TextStyle(
            color: Colors.white
        ),),
        backgroundColor: Colors.indigo.shade300,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 9,
            child: StreamBuilder(
              stream: getMessages(),
              builder: (context,snapshot){
                if(snapshot.connectionState==ConnectionState.waiting){
                  return Text("loading");
                }
                return
                ListView(
                  controller: src,
                children: snapshot.data!.docs.map((e){
                  return Align(
                    alignment: e['senderid']==auth.currentUser!.uid?Alignment.topRight:Alignment.topLeft,
                      child: Container(
                        decoration: BoxDecoration(
                            color:  e['senderid']==auth.currentUser!.uid?Colors.indigo.shade300:Colors.pink.shade300,
                            borderRadius: BorderRadius.circular(7)
                        ),
                        margin: EdgeInsets.symmetric(
                          horizontal: 10,vertical: 1
                        ),
                          padding: EdgeInsets.all(10),
                          child: Text(e['message'],style: TextStyle(
                            color: Colors.white
                          ),)));}).toList(),
              );}
            ),
          ),
          Container(
            height: 60,
            decoration: BoxDecoration(
              border: Border.all(
                    color: Colors.black

              )
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    height: 70,
                    child: TextField(
                      focusNode: focusNode,
                      onSubmitted: (e){
                        if(message.text.trim().isNotEmpty) {
                          sendMessage(message.text);
                          src.animateTo(src.position.maxScrollExtent,
                              duration: Duration(
                                  milliseconds: 100
                              ), curve: Curves.bounceIn);
                          focusNode.requestFocus();
                        }
                        },
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color:Colors.transparent
                              )
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.transparent
                              )
                          ),
                          fillColor: Colors.indigo.shade200,
                          filled: true,
                          hintText: "Enter any message"
                      ),
                      controller: message,
                    ),
                  ),
                ),
                SizedBox(width: 10,),
                InkWell(
                    onTap: (){
                      if(message.text.trim().isNotEmpty) {
                        sendMessage(message.text);
                        src.animateTo(src.position.maxScrollExtent,
                            duration: Duration(
                                milliseconds: 400
                            ), curve: Curves.ease);
                        focusNode.requestFocus();
                      }
                    },
                    child: Icon(Icons.arrow_upward)),
                SizedBox(width: 15,),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
