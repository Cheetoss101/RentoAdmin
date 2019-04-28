import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rentoadmin/UIs/LoginScreen.dart';
import 'package:rentoadmin/UIs/MainPage.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:rentoadmin/api/services.dart';
// 
void main() async{
  //MapView.setApiKey('AIzaSyBTM7tUit-IU6DS0of0rG89rLcaFX1aiFU');
  runApp(
     new MyApp()
    );
}

class MyApp extends StatefulWidget{
  MyAppState createState () => new MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData( 
        primaryColor:  Colors.deepOrange[800]
      ),
      home: LoginScreen(),
      routes: <String, WidgetBuilder>{
         '/LoginScreen' : (BuildContext context) => new LoginScreen(),
         '/MainPage' : (BuildContext context) => new MainPage(),
      },
    );
  }

  @override
  void initState (){
    UserAuth();
    super.initState();
    FirebaseAuth.instance.onAuthStateChanged.listen((user){
      
    });
  }
}
