import 'dart:math';
import 'package:flutter/material.dart';
import 'package:loginui/classes/nav-drawer.dart';
import 'package:loginui/pages/userinterfaces/first.dart';
import 'package:supercharged/supercharged.dart';

class MyWidget extends StatefulWidget {
  final token;
   const MyWidget({@required this.token,Key? key}) : super(key: key);
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
        
        body :Container(
          color :Color.fromARGB(255, 176, 223, 246), 
          child:GridView.count(
  crossAxisCount: 2,
  padding: EdgeInsets.fromLTRB(0.0,40.0,0.0,0.0),
  children: List.generate(6, (index) => Card(
    
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
    color: Color.fromARGB(220, 1, 187, 229), // Replace with your background color), // Background color
     child:InkWell( onTap: () {
        print('hello world');
        Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MyPage(),
        ),
      );
      // Add your desired functionality on tapping here
       // Example for printing a message
    },
      
    child: ClipRRect( // Clipping image to card shape
      borderRadius: BorderRadius.circular(25.0),
      child: Stack( // Stacking image and title
        children: [
          Image.asset( // Replace with your image path
            "assets/img${index}.png",
            fit: BoxFit.cover, // Image to cover card area
          ),
          // Positioned( // Title positioning
          //   bottom: 10.0,
          //   left: 10.0,
            
          //   child: Text(
          //     "${title1.map((e) => (text :e))}", // Replace with your title
          //     style: TextStyle(color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.bold),
          //   ),
          // ),
        ],
      ),
      )
    ),
    
  )
  ),
  )
  ),
        bottomNavigationBar: BottomNavigationBar(
      //  currentIndex: selectedIndex, // selected tab index
       onTap: _onItemTapped, // handle tap on items
       items: [
        BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'Home',
        ),
        BottomNavigationBarItem(
        icon: Icon(Icons.person),
        label: 'profile',
         ),
         // Add items for all your navigation destinations
        ],
         )
         )
           );
  }
  void _onItemTapped(int index) {
  setState(() {
    // selectedIndex = index;
  });
  // Navigate to the respective screen based on the selected index
  
  switch (index) {
    case 0:
      Navigator.pushNamed(context, '/home');
      break;
    case 1:
      Navigator.pushNamed(context, '/settings');
      break;
    // Add cases for navigating to other screens
  }
}

}