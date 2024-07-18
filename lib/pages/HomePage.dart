import 'package:bujjichats/pages/Chat_Page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';

import 'SignUpPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseFirestore firestore=FirebaseFirestore.instance;
  Stream<List<Map<String,dynamic>>> getUserStream(){
    return firestore.collection("Users").snapshots().map((snapshot){
      return snapshot.docs.map((doc){
        final user=doc.data();
        return user;
      }).toList();
    }
    );
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.indigo,
        statusBarColor: Colors.indigo
      // navigation bar color/ status bar color
    ));
    return Scaffold(
      drawer: Drawer(),

      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white
        ),
        elevation: 5,
        shadowColor: Colors.indigo.shade300,
        title: Text("Bujji Chats",style: TextStyle(
          color: Colors.white

        ),),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: ()async{
              FirebaseAuth firebaseAuth=FirebaseAuth.instance;
              await firebaseAuth.signOut();
            },
            icon:Icon(Icons.logout),color: Colors.white,),
          SizedBox(width: 15,)
        ],
        backgroundColor: Colors.indigo.shade300,
      ),
      body: StreamBuilder(
        stream: getUserStream(),
        builder: (context,snapshot){
          if(snapshot.hasError){
            return Text("erro");
          }
          if(snapshot.connectionState==ConnectionState.waiting){
            return Text("LOading");
          }
          return ListView(
            children:snapshot.data!.map((e) {
              FirebaseAuth firebaseAuth=FirebaseAuth.instance;
              if(firebaseAuth.currentUser!.uid==e['uid']){
                return Container();
              }
              return
              InkWell(
                onTap: (){
                  Navigator.of(context).push(PageTransition(child: ChatPage(
                    recieverEmail:e['email'] ,
                    recieverId: e['uid'],
                  ),
                      type: PageTransitionType.fade));
                },
                child: Card(
                  elevation: 0,
                  shadowColor: Colors.indigo.shade300,
                  margin: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 10
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.indigo.shade300,
                      ),
                      borderRadius: BorderRadius.circular(7),
                      color: Colors.indigo.shade50
                    ),
                      height: 65,
                      width: double.infinity,
                      child: Center(child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.person,color: Colors.indigo.shade300,),
                          SizedBox(width: 20,),
                          Text(e['email'].toString(),style: TextStyle(
                            color: Colors.indigo
                          ),),
                        ],
                      ))),
                ),
              );}).toList(),
          );
        },
      ),bottomNavigationBar: Container(
      padding: EdgeInsets.all(10),
      height: 70,
      child: Container(
        decoration: BoxDecoration(

        ),
        color: Colors.indigo,
      ),
    ),
    );
  }
}
