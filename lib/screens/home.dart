import 'package:app3/main.dart';
import 'package:app3/screens/signup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MainScreen());
} 
class MainScreen extends StatefulWidget{
  @override
  _MainScreen createState() => _MainScreen();
}
class _MainScreen extends State<MainScreen>{ 
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    CalendarFormat format = CalendarFormat.month;
    DateTime selectedDay = DateTime.now();
    DateTime focusedDay = DateTime.now();

    return Scaffold(
      resizeToAvoidBottomInset : true,
      //backgroundColor: Colors.black,
      body: 
        Scaffold( 
                resizeToAvoidBottomInset : false,
                backgroundColor: Colors.black,
          body: 
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
             crossAxisAlignment: CrossAxisAlignment.center,
            children: [
               Icon(CupertinoIcons.book_solid),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                child: Text("Overview",
                style: TextStyle(color: Colors.white,
                fontFamily: 'LeagueGothic',
                fontSize: 50),),
              ),
              Container(
             
             child: 
               TableCalendar(
                 
                 focusedDay: DateTime.now(), 
                 firstDay: DateTime(1990), 
                 lastDay: DateTime(2050),
                 calendarFormat: format,
                 onFormatChanged: (CalendarFormat _format){
                 setState(() {
                   format = _format;
                 }
                 );
                 },
                 
                 startingDayOfWeek: StartingDayOfWeek.sunday ,
                 daysOfWeekVisible: true,
                 
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    selectedDay = selectedDay;
                    focusedDay = focusedDay; 
                    print(focusedDay);// update `_focusedDay` here as well
                  }
                  );
                }, 
                selectedDayPredicate: (day) {
                  return isSameDay(selectedDay, day);
                },
                 onPageChanged: (_focusedDay) {
                      focusedDay = _focusedDay;
                    },
                  calendarStyle: CalendarStyle(
                    isTodayHighlighted: true,
                    selectedDecoration: BoxDecoration(
                      color: Colors.blueGrey,
                      shape: BoxShape.circle,
                    ),
                    selectedTextStyle: TextStyle(
                      color: Colors.white,
                    ),
                    todayDecoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(5.0)
                    )
                  ),
                  headerStyle: HeaderStyle(
                    formatButtonVisible: false,
                    titleCentered: true,
                    formatButtonShowsNext: false
                  ),
                 ),
              ),
                 Text(DateFormat.yMMMd().format(DateTime.now())),
                 Text('You are logged in as:',
                 style: TextStyle(
                   fontFamily: 'LeagueGothic',
                   fontSize: 20,

                 ),),
               Text(
                 user.email!,
                 style: TextStyle(fontSize: 20
                 , fontFamily: 'LeagueGothic',
                 color: Colors.white),
               ),
             
           
         ],
       )
            
        ),
        
         
    
    );
    
    }
  }
