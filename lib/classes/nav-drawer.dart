import 'package:flutter/material.dart';
import 'package:loginui/pages/authenauthor/login.dart';
import 'package:loginui/pages/userinterfaces/feedback.dart';
import 'package:loginui/pages/userinterfaces/home.dart';
import 'package:loginui/pages/userinterfaces/profilepage.dart';

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            // child: Text(
            //   '',
            //   style: TextStyle(color: Color.fromARGB(246, 66, 3, 147), fontSize: 30,fontWeight: FontWeight.bold),
            // ),
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 180, 217, 235),
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/logo1.png'))), child: null,
          ),
          ListTile(
            leading: Icon(Icons.input),
            title: Text('Welcome'),
            onTap: () => {Navigator.push(context, MaterialPageRoute(builder: (context)=>MyWidget()))},
          ),
          ListTile(
            leading: Icon(Icons.verified_user),
            title: Text('Profile'),
            onTap: () => {Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfilePage()))},
          ),
          // ListTile(
          //   leading: Icon(Icons.settings),
          //   title: Text('Settings'),
          //   // onTap: () => {Navigator.push(context, MaterialPageRoute(builder: (context)=>()))},
          // ),
          ListTile(
            leading: Icon(Icons.border_color),
            title: Text('Feedback'),
            onTap: () => {Navigator.push(context, MaterialPageRoute(builder: (context)=>FeedbackPage()))},
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () => {Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginView()))},
          ),
        ],
      ),
    );
  }
}