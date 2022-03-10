

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
  runApp(MainScreen());
} 

class MainScreen extends StatelessWidget{

 
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      resizeToAvoidBottomInset : false,

      body: 
       Column(
         children: [
           Container(
             
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
           ),
           Column(
             mainAxisAlignment: MainAxisAlignment.center,
             crossAxisAlignment: CrossAxisAlignment.center,
             children: [
               Text(
                 user.email!,
                 style: TextStyle(fontSize: 20
                 , fontFamily: 'LeagueGothic'),
               ),
             ],
           ),
         ],
       )
    );
   
    }
  }
