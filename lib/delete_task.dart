import 'package:flutter/material.dart';
import 'package:zulfi/home_screen.dart';

class DeleteTaskScreen extends StatefulWidget{
  const DeleteTaskScreen({super.key});
  @override
  AppState createState() => AppState();
}
class AppState extends State <DeleteTaskScreen>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
    appBar: AppBar(
      title: Text('Delete Screen'),
    ),
    backgroundColor: Colors.white,
    body: Text('Delete Task Screen'),
    );
}
}