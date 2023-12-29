import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:loginui/classes/nav-drawer.dart';
import 'package:loginui/pages/authenauthor/config.dart';
import 'package:loginui/pages/userinterfaces/service.dart';
import 'package:loginui/pages/userinterfaces/profilepage.dart';
import 'package:http/http.dart' as http;
import 'package:loginui/pages/admin/adminpage.dart';



class MyWidget extends StatefulWidget {
 
  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
    List<DataModel?> dataModel = []; // Remove static keyword

  @override
void initState() {
  super.initState();
   fetchData();
}

   Future<void> fetchData() async {
    final response = await http.get(Uri.parse(getContent));
    if (response.statusCode == 200) {
      final dynamic responseData = jsonDecode(response.body);

      print('Response Body: $responseData');

      if (responseData != null && responseData['content'] is List<dynamic>) {
        final List<dynamic> stepsList = responseData['content'];
        print('Success to get steps. Status code: ${response.statusCode}');
        setState(() {
          dataModel = stepsList
              .map((step) => DataModel(
                    title: step['title'],
                    description: step['description'],
                    steps: List<String>.from(step['content']),
                  ))
              .toList();
        });
      } else {
        print('Invalid response format or missing "content" key.');
        // Handle invalid data if needed
      }
    } else {
      print('Failed to get steps. Status code: ${response.statusCode}');
      // Handle failure if needed
    }
  }

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
  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 40.0),
  child: GridView.count(
    crossAxisCount: 2,
    children: List.generate(dataModel.length, (index) => Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      color: Color.fromARGB(220, 1, 187, 229),
      child: InkWell(
        onTap: () {
          print('Card tapped with index: $index');
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MyPage(
                index: index,
                title: dataModel[index]!.title,
                description: dataModel[index]!.description,
                steps: dataModel[index]!.steps,
              ),
            ),
          );
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Stack(
            children: [
              Image.asset(
                "assets/img${index}.png",
                fit: BoxFit.cover,
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  color: Color.fromARGB(180, 1, 187, 229),
                  padding: EdgeInsets.symmetric(vertical: 7.0, horizontal: 14.0),
                  child: Text(
                    dataModel[index]!.title,
                    style: TextStyle(
                      color: Color.fromARGB(255, 245, 242, 242),
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
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
  setState(() {
    // selectedIndex = index;
  });
  // Navigate to the respective screen based on the selected index
  
  switch (index) {
    case 0:
     {Navigator.push(context, MaterialPageRoute(builder: (context)=>MyWidget()));}
     break;
    case 1:
    {Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfilePage()));}
     break;
    // Add cases for navigating to other screens
    }
  }
}
