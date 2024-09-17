import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  AppState createState() => AppState();
}

class AppState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Main Screen'),
        //centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          TextField(
            decoration: InputDecoration(
              label: Text('Enter name'),
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          ElevatedButton(onPressed: () {}, child: Text('button 1')),
          SizedBox(
            height: 10,
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text('button 2'),
          ),
          SizedBox(
            height: 10,
          ),
          Icon(
            Icons.person,
            //color: Colors.black,
          ),
          SizedBox(
            height: 10,
          ),
          Text('I am not picky blinder'),
          SizedBox(
            height: 10,
          ),
          Icon(
            Icons.add,
            //color: Colors.yellow,
          ),
          SizedBox(
            height: 10,
          ),
          Text('Let me do it myself'),
          SizedBox(
            height: 10,
          ),
          TextField(
            decoration: InputDecoration(
                border: OutlineInputBorder(), label: Text('Text Field')),
          ),
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(
              padding: EdgeInsets.zero,
              child: const Text('Drawer'),
              decoration: BoxDecoration(
                color: Colors.teal,
              ),
            ),
            ListTile(
              title: const Text('Settings'),
              leading: Icon(Icons.settings),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Contact us'),
              leading: Icon(Icons.contact_mail),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('About Us'),
              leading: Icon(Icons.person),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
