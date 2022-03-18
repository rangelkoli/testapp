import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:ui';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Signup());
} 

class NewApp extends StatelessWidget{

  @override
  Widget build(BuildContext context){
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  return MaterialApp(
      home: Signup(),
    );
  }
}
class Signup extends StatelessWidget{
  var name = '';
  var email = '';
  var password = '';
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  @override
  Future signupwithemail() async {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailcontroller.text.trim(),
        password: passwordcontroller.text.trim());
      } on FirebaseAuthException catch (e){
        print(e);
      }
 }
  @override
  Widget build(BuildContext context) {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  CollectionReference users = FirebaseFirestore.instance.collection('users');
    return Scaffold(
                resizeToAvoidBottomInset : false,

      body: Container(
        
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/cloudsbg.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // StreamBuilder<QuerySnapshot>(stream: users,
            // builder: (
            //   BuildContext context,
            //   AsyncSnapshot<QuerySnapshot> snapshot,
            // ),),
            Padding(
              padding: const EdgeInsets.fromLTRB(0,50,0,0),
              child: Text("SignUp Page",
              style: TextStyle(
                fontSize: 60,
                fontFamily: 'LeagueGothic', 
                              ),
              ),
            ),
            Container(
              height: 300,
              decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage("assets/images/welcome.png"),
            fit: BoxFit.cover,
          ),
        ),
            ),
      Padding(padding: EdgeInsets.all(10),
      child: TextField(
              onChanged: ((value) {
              email = value;
            }),
            controller: emailcontroller,
            decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Email',
            hintText: 'Enter your Email'
          ), ),
      ),
      Padding(
        padding: EdgeInsets.all(10),
        child: TextField(
           onChanged: ((value) {
              password = value;
            }),
            controller: passwordcontroller,
            obscureText: true,
            decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Password',
            hintText: 'Enter your secure password',
          ),
        ),
      ),
            RaisedButton(onPressed: (){
              signupwithemail();
              users.add({'name': name, 'email': email, 'password': password})
              .then((value) => print('User Added'))
              .catchError((error) => print('Failed'));
              Navigator.pushNamed(context, '/loginpage');
            },
            
            child: Text('Submit'),
            )
          ],
        ),
    ),
    );
   
  }
  
}