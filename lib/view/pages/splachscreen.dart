
import 'package:flutter/material.dart';
import 'package:freelance_app/view/pages/login.dart';
import 'package:splashscreen/splashscreen.dart';
void main(){
  runApp(new MaterialApp(
    home: new MyApp(),
  ));
}


class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
        seconds: 3,
        navigateAfterSeconds: new Login(),
        image: new  Image.asset('assets/images/logowhite.png'),
        title: new Text('GLITCHTEC',
          style: new TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 60.0,
              color:Colors.white
          ),),

        imageBackground: AssetImage('assets/images/firstpage.png'),

        backgroundColor: Colors.white,
        styleTextUnderTheLoader: new TextStyle(),
        photoSize: 100.0,
        onClick: ()=>print("Flutter "),
        loaderColor: Color(0x00000000)
    );
  }
}
