import 'package:flutter/material.dart';
import 'package:zulfi/add_task.dart';
import 'package:zulfi/delete_task.dart';
import 'package:zulfi/view_tasks.dart';
import 'home_screen.dart';

void main() {
  runApp(const ToDo());
}

class ToDo extends StatelessWidget {
  const ToDo({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'zulfi',
      //Structuring the app
      theme: ThemeData(
        //appbar theme
        appBarTheme: const AppBarTheme(
            color: Colors.teal,
            centerTitle: true,
            iconTheme: IconThemeData(color: Colors.white),
            titleTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            )),
        //Elevated button
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
          backgroundColor: Colors.teal,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          //padding: EdgeInsets.symmetric(horizontal: 16,vertical: 12),
        )),
        //Icon Themes
        iconTheme: IconThemeData(
          color: Colors.teal,
          size: 30,
        ),
        //Text Field
        inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: Colors.grey[200],
            labelStyle: TextStyle(color: Colors.teal),
            hintStyle: TextStyle(color: Colors.grey),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.teal),
              borderRadius: BorderRadius.circular(8),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
              borderRadius: BorderRadius.circular(8),
            )),
      ),
      routes: {
        'add': (context) => AddTaskScreen(),
        'delete': (context) => DeleteTaskScreen(),
        'view': (context) => ViewTasksScreen(),
      }
      ,
      home: const HomeScreen(),
    );
  }
}
