import 'package:bujjichats/firebase_options.dart';
import 'package:bujjichats/providers/central_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'pages/HomePage.dart';
import 'pages/LoginPage.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(
      ChangeNotifierProvider(
        create: (context) => CentralProvider(),
          child:App()));
}
class App extends StatefulWidget {
  const App({super.key});
  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CentralProvider>(
      builder:(context,value,child)=> MaterialApp(
        debugShowCheckedModeBanner: false,
          darkTheme:value.darkTheme,
        theme: value.lightTheme,
        home: MyApp(),
      ),
    );
  }
}
class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            return HomePage();
          }
          else{
            return LoginPage();
          }
        },
    );
  }
}
