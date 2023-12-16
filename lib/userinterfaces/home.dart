import 'dart:math';
import 'package:flutter/material.dart';
import 'package:loginui/authenauthor/login.dart';
import 'package:loginui/userinterfaces/passport.dart';
import 'package:loginui/authenauthor/signup.dart';
import 'package:loginui/authenauthor/forgot_password.dart';
import 'package:loginui/authenauthor/pin_code.dart';
import 'package:loginui/classes/fadeanimation.dart';
import 'package:loginui/classes/nav-drawer.dart';
import 'package:supercharged/supercharged.dart';

class MyWidget extends StatefulWidget {
  final token;
   const MyWidget({@required this.token,Key? key}) : super(key: key);
  @override
  State<MyWidget> createState() => _MyWidgetState();
}
List<String> title1 = [
  "Passport","Enlistment","Disabeled Car","Customs","Scholarship"
];
class _MyWidgetState extends State<MyWidget> {
   @override
  Widget build(BuildContext context) {
    const title = 'Dalelk';
    return MaterialApp(
      title: title,
      home: Scaffold(
        drawer : NavDrawer(),
        appBar: AppBar(
          title: const Text(title),
        ),
        
        body :Container(
          color :Color.fromARGB(255, 26, 163, 226), 
          child:GridView.count(
  crossAxisCount: 2,
  padding: EdgeInsets.fromLTRB(0.0,40.0,0.0,0.0),
  children: List.generate(6, (index) => Card(
    
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
    color: Color.fromARGB(255, 35, 45, 102), // Replace with your background color), // Background color
     child:InkWell( onTap: () {
        Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Dalelk0(),
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
),)
       )   );
  }
}