import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:loginui/pages/authenauthor/config.dart';
import 'package:loginui/pages/userinterfaces/home.dart';

// Model for structured data
class DataModel {
  final String title;
  final String description;
  final List<String> steps;

  DataModel({required this.title, required this.description, required this.steps});

  // Factory constructor to create DataModel instances from JSON
  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      title: json['title'],
      description: json['description'],
      steps: (json['steps'] as List<dynamic>).cast<String>(),
    );
  }
}

// Custom widget for each step
class StepItem extends StatefulWidget {
  final String steps;

  const StepItem({required this.steps});

  @override
  _StepItemState createState() => _StepItemState();
}

class _StepItemState extends State<StepItem> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.steps),
      trailing: Checkbox(
        value: isChecked,
        onChanged: (value) {
          setState(() {
            isChecked = value!;
          });
        },
      ),
    );
  }
}

// Main page widget
class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  static List<DataModel> dataModel = []; // Initialize as empty list

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  static Future<List<DataModel>> fetchData() async {
    final response = await http.get(Uri.parse(getContent));
    if (response.statusCode == 200) {
      final dynamic responseData = jsonDecode(response.body);

      print('Response Body: $responseData');

      if (responseData != null && responseData['content'] is List<dynamic>) {
        final List<dynamic> stepsList = responseData['content'];
        print('Success to get steps. Status code: ${response.statusCode}');
        return dataModel = stepsList
            .map((step) => DataModel(
                title: step['title'],
                description: step['description'],
                steps: List<String>.from(step['content']),
              ))
            .toList();
      } else {
        print('Invalid response format or missing "content" key.');
        return []; // Return an empty list in case of invalid data
      }
    } else {
      print('Failed to get steps. Status code: ${response.statusCode}');
      return []; // Return an empty list in case of failure
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(dataModel.isNotEmpty ? dataModel[0].title : 'Loading...'),
      ),
      body: StreamBuilder<List<DataModel>>(
  stream: Stream.fromFuture(fetchData()),
  builder: (context, snapshot) {
    if (snapshot.hasData) {
      return ListView.builder(
        itemCount: snapshot.data!.length,
        itemBuilder: (context, outerIndex) {
          final dataItem = snapshot.data![outerIndex];
          return ExpansionTile(
            title: Text("Procedures"),
            children: [
              ListView.builder(
                shrinkWrap: true, // Allow for variable-length content
                physics: NeverScrollableScrollPhysics(), // Disable nested scrolling
                itemCount: dataItem.steps.length,
                itemBuilder: (context, innerIndex) {
                  return StepItem(steps: dataItem.steps[innerIndex]);
                },
              ),
            ],
          );
        },
      );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error fetching data: ${snapshot.error}'));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),  bottomNavigationBar: BottomNavigationBar(
      //  currentIndex: selectedIndex, // selected tab index
      //  onTap: _onItemTapped, // handle tap on items
       items: [
        BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'Home',
        ),
        BottomNavigationBarItem(
        icon: Icon(Icons.help_outline),
        label: 'inquiry',
         ),
         // Add items for all your navigation destinations
        ],
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
      Navigator.pushNamed(context, '/settings');
      break;
    // Add cases for navigating to other screens
  }
}
 }

