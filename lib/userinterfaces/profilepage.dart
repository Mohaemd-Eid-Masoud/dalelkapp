// import 'package:flutter/material.dart';
// import 'package:loginui/editprofile.dart';

// class ProfilePage extends StatefulWidget {
//   final User user; // Your user data model
// final token;
//    const ProfilePage({@required this.token,Key? key, required this.user}) : super(key: key);
//   @override
//   _ProfilePageState createState() => _ProfilePageState();
// }

// class User {
//   get bio => null;
  
//   String? get username => null;
  
//   String? get email => null;
  
//   String? get imageUrl => null;
// }

// class _ProfilePageState extends State<ProfilePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("My Profile"),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             // Profile picture
//             CircleAvatar(
//               radius: 50.0,
//               backgroundImage: NetworkImage(widget.user.imageUrl),
//             ),
//             SizedBox(height: 20.0),
//             // Username
//             Text(
//               widget.user.username,
//               style: Theme.of(context).textTheme.headline6,
//             ),
//             // Email address
//             Text(
//               widget.user.email,
//               style: Theme.of(context).textTheme.subtitle1,
//             ),
//             SizedBox(height: 20.0),
//             // Bio
//             Text(
//               widget.user.bio,
//               style: Theme.of(context).textTheme.bodyText1,
//             ),
//             SizedBox(height: 20.0),
//             // Edit profile button
//             //ElevatedButton(
//               // onPressed: () => Navigator.push(
//               //   context,
//               //   MaterialPageRoute(builder: (context) => const EditProfilePage(token)),
//               // ),
//              // child: Text("Edit Profile"),
//             //),
//           ],
//         ),
//       ),
//     );
//   }
// }

