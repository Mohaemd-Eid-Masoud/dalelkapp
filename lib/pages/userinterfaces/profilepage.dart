import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loginui/pages/authenauthor/config.dart';
import 'package:supercharged/supercharged.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class User {
  String username;
  String email;
  String imageUrl;
  String gender;
  String phoneNumber;
  DateTime birthdate;

  User({
    required this.username,
    required this.email,
    required this.imageUrl,
    required this.gender,
    required this.phoneNumber,
    required this.birthdate,
  });
}

class _ProfilePageState extends State<ProfilePage> {
  User user = User(
    username: "john_doe",
    email: "john@example.com",
    imageUrl: "https://example.com/default_image.jpg",
    gender: "",
    phoneNumber: "",
    birthdate: DateTime.now(),
  );

  final ImagePicker _imagePicker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      var request = http.MultipartRequest('POST', Uri.parse(uploadimage));
      request.files.add(await http.MultipartFile.fromPath('image', pickedFile.path));

      var response = await request.send();

      if (response.statusCode == 200) {
        setState(() {
          user.imageUrl = pickedFile.path;
        });
      } else {
        print('Failed to upload image. Status code: ${response.statusCode}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Profile"),
        backgroundColor: Color.fromARGB(255, 197, 220, 246), // Change app bar color
      ),
      backgroundColor: Color.fromARGB(255, 205, 234, 249),
 // Change background color
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  radius: 80.0,
                  backgroundImage: user.imageUrl != null && user.imageUrl.startsWith('http')
                      ? NetworkImage(user.imageUrl) as ImageProvider<Object>?
                      : user.imageUrl != null
                          ? FileImage(File(user.imageUrl))
                          : AssetImage('assets/logo1.png') as ImageProvider<Object>?,
                ),
                GestureDetector(
                  onTap: _pickImage,
                  child: CircleAvatar(
                    radius: 18.0,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.edit,
                      color: Color.fromARGB(255, 129, 182, 243), // Change edit icon color
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: TextFormField(
                    initialValue: "John",
                    decoration: InputDecoration(
                      labelText: "First Name",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 10.0),
                Expanded(
                  child: TextFormField(
                    initialValue: "Doe",
                    decoration: InputDecoration(
                      labelText: "Last Name",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            TextFormField(
              initialValue: user.username,
              decoration: InputDecoration(
                labelText: "Username",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20.0),
            TextFormField(
              initialValue: user.email,
              decoration: InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
              ),
              readOnly: true,
            ),
            SizedBox(height: 20.0),
            TextFormField(
              initialValue: user.gender,
              decoration: InputDecoration(
                labelText: "Gender",
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  user.gender = value;
                });
              },
            ),
            SizedBox(height: 20.0),
            TextFormField(
              initialValue: user.phoneNumber,
              decoration: InputDecoration(
                labelText: "Phone Number",
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  user.phoneNumber = value;
                });
              },
            ),
            SizedBox(height: 20.0),
            TextFormField(
              readOnly: true,
              onTap: () async {
                final DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: user.birthdate,
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                );
                if (picked != null && picked != user.birthdate) {
                  setState(() {
                    user.birthdate = picked;
                  });
                }
              },
              controller: TextEditingController(
                text: user.birthdate.toLocal().toString().split(' ')[0],
              ),
              decoration: InputDecoration(
                labelText: "Birthdate",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Handle the save changes logic
              },
              child: Text("Save Changes"),
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 197, 220, 246), // Change button color
              ),
            ),
          ],
        ),
      ),
    );
  }
}
