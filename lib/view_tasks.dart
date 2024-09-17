import 'package:flutter/material.dart';
import 'package:zulfi/home_screen.dart';

class ViewTasksScreen extends StatefulWidget{
  const ViewTasksScreen({super.key});
  @override
  AppState createState() => AppState();
}
class AppState extends State <ViewTasksScreen>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('View Task Screen'),
      ),
      backgroundColor: Colors.white,
      body: Text('View Task Screen'),
    );
  }
}