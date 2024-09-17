import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:zulfi/add_task.dart';
import 'package:zulfi/delete_task.dart';
import 'package:zulfi/view_tasks.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  AppState createState() => AppState();
}

class AppState extends State<HomeScreen> {
  int selectedIndex = 1;
  void demo(int index) {}
  //method for changing screen in bottom navigation bar items
  void changeScreen(int index) {
    setState(() {
      selectedIndex = index;
    });
    //navigation
    switch (selectedIndex) {
      case 0:
        Navigator.pushNamed(context, 'add');
        break;
      case 1:
        Navigator.pushNamed(context, 'delete');
        break;
      case 2:
        Navigator.pushNamed(context, 'view');
    }
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(index.toString())));
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Main Screen'),
          backgroundColor: Colors.teal,
          actions: [
            IconButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                      'SnakeBar',
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.teal,
                  ));
                },
                icon: Icon(Icons.more_vert)),
          ],
          bottom: TabBar(
            labelColor: Colors.black, // for selected tab ( text and icon )
            labelStyle: TextStyle(fontWeight: FontWeight.bold),
            unselectedLabelColor: Colors.white, //for unselected tabs (text and icon both)
            tabs: [
              Tab(
                icon: Icon(
                  Icons.add,
                ),
                text: 'Add Task',
              ),
              Tab(
                  icon: Icon(
                    Icons.delete,
                  ),
                  text: 'Delete'),
              Tab(
                icon: Icon(
                  Icons.person,
                ),
                text: 'View',
              ),
            ],
          ),
        ),
        // backgroundColor: Colors.white,
        body: TabBarView(
          children: [
            AddTaskScreen(),
            DeleteTaskScreen(),
            ViewTasksScreen(),
          ],
        ),

        // code for drawer
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

        //Code for Bottom navigation bar
        bottomNavigationBar: BottomNavigationBar(
          unselectedItemColor: Colors.white,
          selectedItemColor: Colors.black,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.add,
              ),
              label: 'Add',
            ),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.delete,
                ),
                label: 'Delete'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                ),
                label: 'View'),
          ],
          currentIndex: selectedIndex,
          // onTap: changeScreen,
          onTap: demo,
          backgroundColor: Colors.teal,
        //  selectedIconTheme: IconThemeData(color: Colors.teal),
        ),

        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          backgroundColor: Colors.teal,
        ),
      ),
    );
  }
}
