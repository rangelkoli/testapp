

import 'package:app3/main.dart';
import 'package:app3/screens/signup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(LoginPage());
} 

class LoginPage extends StatelessWidget{
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  @override
  Future signIn() async {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailcontroller.text.trim(),
        password: passwordcontroller.text.trim());
 }
  void dispose(){
    emailcontroller.dispose();
    passwordcontroller.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,

      body: 
        StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData){
              return HomePage();
            } 
            return Container(
            
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/cloudsbg.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
            //     Container(
            //       height: 300,
            //       decoration: BoxDecoration(
            //   image: DecorationImage(
            //     image: const AssetImage("assets/images/welcome.png"),
            //     fit: BoxFit.cover,
            //   ),
            // ),
            //     ),
                Text("Login Page",
                style: TextStyle(
                  fontSize: 60,
                  fontFamily: 'LeagueGothic', 
                  
                  //fontFamily: 
                  // fontFamily: 
                     // 'Schyler'
                ),
                ),
                Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: emailcontroller,
                decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'User Name',
                hintText: 'Enter valid mail id as abc@gmail.com'
              ),
            ),
              ),
              Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
               controller: passwordcontroller,
                obscureText: true,
                decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
                hintText: 'Enter your secure password'
              ),
            ),
              ),
            FlatButton(onPressed: (){
                Navigator.pushNamed(context, '/signup');
        
         }, 
              child: Text("New Here? Sign Up")),
        
                RaisedButton(onPressed: (){
                  signIn();
                  Navigator.pushNamed(context, '/');
                }
                ,
                child: Text('Submit'),
                )
              ],
            ),
            );
          }
        ),
    );
   
    }
  }
