import 'package:bujjichats/pages/LoginPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';

import '../components/login_text_fIeld.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailid=TextEditingController();
  TextEditingController password=TextEditingController();
  TextEditingController confirmPassword=TextEditingController();
  void signUp(BuildContext context)async{
    FirebaseAuth firebaseAuth=FirebaseAuth.instance;
    FirebaseFirestore firestore=FirebaseFirestore.instance;
    try{
      UserCredential userCredential=await firebaseAuth.createUserWithEmailAndPassword(email: emailid.text,
          password: password.text);
      firestore.collection("Users").doc(userCredential.user!.uid).set(
        {
          'uid':userCredential.user!.uid,
          'email':emailid.text
        }
      );
    }
    catch(e){
      print("cred"+e.toString());
    }
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.indigo.shade300,
        statusBarColor: Colors.indigo.shade300
      // navigation bar color/ status bar color
    ));
    return
      Scaffold(
          backgroundColor: Colors.indigo.shade300,
          body:
      SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 100,),
              Text("Bujji Chats",style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
              ),),
              Image.asset("assets/chatt.png",height: 70,width: 70,
                  color: Colors.white),
              SizedBox(height: 30,),
              LoginTextField(
                obscure: false,
                hintText: "Email Id",
                controller: emailid,
              ),
              SizedBox(height: 20,),
              LoginTextField(
                obscure: true,
                hintText: "Password",
                controller: password,
              ),
              SizedBox(height: 20,),
              LoginTextField(
                obscure: true,
                hintText: "Confirm Password",
                controller:confirmPassword,
              ),
              SizedBox(height: 20,),
              Padding(
                padding: EdgeInsets.all(20),
                child: InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: (){
                    signUp(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.white
                      ),
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.indigo.shade600,
                    ),
                    child: Center(
                      child: Text("Sign Up",style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                      ),),
                    ),
                    height: 70,
                    width: double.infinity,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already Registered?",style: TextStyle(
                      color: Colors.white
                  ),),SizedBox(width: 5,),
                  InkWell(
                    onTap: (){
                      Navigator.of(context).pushReplacement(PageTransition(child: LoginPage(),
                          type: PageTransitionType.fade));
                    },
                    child: Text("Login in",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.white
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30,)
            ],
          ),
        )));
  }
}
