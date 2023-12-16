// import 'package:flutter/material.dart';
// import 'package:loginui/profilepage.dart';

// class EditProfilePage extends StatefulWidget {
//   final User user; // Your user data model

//   const EditProfilePage(token, {required this.user});

//   @override
//   _EditProfilePageState createState() => _EditProfilePageState();
// }

// class _EditProfilePageState extends State<EditProfilePage> {
//   final _formKey = GlobalKey<FormState>();
//   final _bioController = TextEditingController(text: widget.user.bio);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Edit Profile"),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.check),
//             onPressed: () => _saveProfile(),
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               // Profile picture editing
//               SizedBox(height: 20.0),
//               ElevatedButton(
//                 onPressed: () {
//                   // Implement image selection logic
//                 },
//                 child: Text("Change Profile Picture"),
//               ),
//               // Username (usually non-editable)
//               SizedBox(height: 20.0),
//               Text(
//                 widget.user.username,
//                 style: Theme.of(context).textTheme.headline6,
//               ),
//               // Email address (usually non-editable)
//               SizedBox(height: 20.0),
//               Text(
//                 widget.user.email,
//                 style: Theme.of(context).textTheme.subtitle1,
//               ),
//               // Bio editing
//               SizedBox(height: 20.0),
//               TextFormField(
//                 controller: _bioController,
//                 decoration: InputDecoration(
//                   labelText: "Bio",
//                   border: OutlineInputBorder(),
//                 ),
//                 validator: (value) => value!.isEmpty ? "Bio cannot be empty" : null,
//               ),
//               SizedBox(height: 20.0),
//               // Save button
//               ElevatedButton(
//                 onPressed: () => _saveProfile(),
//                 child: Text("Save Changes"),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void _saveProfile() async {
//     if (_formKey.currentState!.validate()) {
//       // Update user data with new bio or other edited fields
//       // Send updated data to your backend

//       // Show success message and navigate back to profile page
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Profile updated successfully")),
//       );
//       Navigator.pop(context);
//     }
//   }
// }
