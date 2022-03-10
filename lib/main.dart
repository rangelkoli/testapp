
import 'package:app3/screens/loginpage.dart';
import 'package:app3/screens/signup.dart';
import 'package:app3/screens/home.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(
    MaterialApp(
       theme: ThemeData(
    textTheme: TextTheme(
      bodyText1: TextStyle(),
      bodyText2: TextStyle(),
      subtitle1: TextStyle(color: Colors.white), // <-- that's the one

    ).apply(
      bodyColor: Colors.white, 
      displayColor: Colors.white, 
    ),
  ),
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => HomePage(),
        '/loginpage': (context) => LoginPage(),
        '/signup' : (context) => Signup(),
        '/home' :(context) => MainScreen(),
      },
    )
  );
}


class AnimatedImage extends StatefulWidget {
  const AnimatedImage({ Key? key }) : super(key: key);

  @override
  State<AnimatedImage> createState() => _AnimatedImageState();
}

class _AnimatedImageState extends State<AnimatedImage>
    with SingleTickerProviderStateMixin {
  late AnimationController  _controller = AnimationController(vsync: this,
  duration: const Duration(seconds: 3))..repeat(reverse: true);
  late final Animation<Offset> _animation = Tween(
    begin: Offset.zero,
    end: Offset(0,0.08),
  ).animate(_controller);
  @override
  

  @override
  void dispose() {
     
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      
      position: _animation,
      child: Image.asset('assets/images/welcome.png'),
    );
  }
}

class HomePage extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      resizeToAvoidBottomInset : false,

      body: Container(
        
        width: double.infinity,
        height: double.infinity,
        
              decoration: BoxDecoration(
               gradient: LinearGradient(
              begin: Alignment.topRight,
               end: Alignment.bottomLeft,
               colors: [
               Color.fromARGB(255, 31, 29, 29),
                Color.fromARGB(255, 19, 149, 255),
               ],
               ),
             ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            
            Padding(
              padding: const EdgeInsets.fromLTRB(0,50,0,0),
              child: Text("Welcome Page",
              style: TextStyle(fontFamily: 'LeagueGothic',
              fontSize: 65,
              color: Colors.white),
                            
              ),
            ),
            AnimatedImage(),
            Padding(
        padding: EdgeInsets.all(10),
        child: TextField(
          
            decoration: InputDecoration(
            fillColor: Colors.white,
            border: OutlineInputBorder(),
            labelText: 'User Name',
            hintText: 'Enter Username'
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.all(10),
        child: TextField(
            obscureText: true,
            
            decoration: InputDecoration(
            fillColor: Colors.white,
            border: OutlineInputBorder(),
            labelText: 'Password',
            hintText: 'Enter your secure password'
          ),
        ),
      ),
      
    TextButton(onPressed: (){
            
            Navigator.pushNamed(context, '/signup');

 }, 
          child: Text("New Here? Sign Up")),

            RaisedButton(onPressed: (){
              Navigator.pushNamed(context, '/loginpage');
            }
            ,
            child: Text('Submit'),
            ),
            RaisedButton(onPressed: ()=> FirebaseAuth.instance.signOut()),
          ],
        ),
    ),
    );
  }
}


