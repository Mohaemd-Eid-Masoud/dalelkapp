import 'dart:math';
import 'package:flutter/material.dart';
import 'package:loginui/classes/nav-drawer.dart';
import 'package:loginui/pages/userinterfaces/first.dart';
import 'package:supercharged/supercharged.dart';

class MyWidget extends StatefulWidget {
 
  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  // var selectedIndex=0;
   @override
  Widget build(BuildContext context) {
    
    const title = 'Dalelk';
    return MaterialApp(
      title: title,
      debugShowCheckedModeBanner: false,
           home: Scaffold(
        drawer : NavDrawer(),
        appBar: AppBar(
          title: const Text(title),
        ),
        
         body: Container(
        color: Color.fromARGB(255, 176, 223, 246),
        child: GridView.count(
          crossAxisCount: 2,
          padding: EdgeInsets.fromLTRB(0.0, 40.0, 0.0, 0.0),
          children: List.generate(6, (index) => Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            color: Color.fromARGB(220, 1, 187, 229),
            child: InkWell(
              onTap: () {
                print('Card tapped with index: $index');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyPage(),
                  ),
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25.0),
                child: Stack(
                  children: [
                    Image.asset(
                      "assets/img${index}.png",
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
              ),
            ),
          )),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    )
    );
  }

  void _onItemTapped(int index) {
    // Handle bottom navigation item tap
  }
}

