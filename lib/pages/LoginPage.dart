import 'package:bujjichats/components/login_text_fIeld.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:page_transition/page_transition.dart';
import 'SignUpPage.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailid=TextEditingController();
  TextEditingController password=TextEditingController();
  Future<void> signIn(BuildContext context)async{
    FirebaseAuth firebaseAuth=FirebaseAuth.instance;
    try{
    UserCredential userCredential=await firebaseAuth.signInWithEmailAndPassword(email: emailid.text,
        password: password.text);
    }
    catch(e){
      showDialog(context: context, builder:(context)=>AlertDialog(
        title: Text("Wrong username or password"),
      ));
    }
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.indigo.shade300,
      statusBarColor: Colors.indigo.shade300
      // navigation bar color/ status bar color
    ));
    return Scaffold(
      backgroundColor: Colors.indigo.shade300,
      body:  SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 150,),
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
                    obscure:true,
                    hintText: "Password",
                    controller: password,
                  ),
                  SizedBox(height: 20,),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: (){
                        signIn(context);
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
                          child: Text("Login",style: TextStyle(
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
                      Text("New User?",style: TextStyle(
                        color: Colors.white
                      ),),SizedBox(width: 5,),
                      InkWell(
                        onTap: (){
                          Navigator.of(context).pushReplacement(PageTransition(child: SignUpPage(),
                              type: PageTransitionType.fade));
                        },
                        child: Text("Sign Up",
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
            )),
    );
  }
}
