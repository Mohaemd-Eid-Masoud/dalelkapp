import 'package:flutter/material.dart';
import 'package:loginui/pages/userinterfaces/home.dart';

class DataModel {
  final String title;
  final String description;
  final List<String> steps;

  DataModel({required this.title, required this.description, required this.steps});

  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      title: json['title'],
      description: json['description'],
      steps: (json['steps'] as List<dynamic>).cast<String>(),
    );
  }
}

class StepItem extends StatefulWidget {
  final String description;

  const StepItem({required this.description});

  @override
  _StepItemState createState() => _StepItemState();
}

class _StepItemState extends State<StepItem> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        widget.description,
        style: TextStyle(
          color: Colors.blue,
        ),
      ),
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

class MyPage extends StatefulWidget {
  final int index;
  final String title;
  final String description;
  final List<String> steps;

  MyPage({required this.index, required this.title, required this.description, required this.steps});

  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  List<DataModel> dataModel = [];

  // Function to handle storing written dialogue
  void storeDialogue(String dialogue) {
    // Add your logic to store the written dialogue
    print('Stored Dialogue: $dialogue');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              child: Column(
                children: [
                  ListTile(
                    title: Text(
                      widget.description,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Column(
                    children: widget.steps.map((step) => StepItem(description: step)).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        color: Colors.blue,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => MyWidget()));
              },
            ),
            IconButton(
              icon: Icon(Icons.mail),
              onPressed: () {
                // Handle inquiry action
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Inquiry"),
                      content: TextField(
                        decoration: InputDecoration(labelText: 'Enter your message'),
                        onSubmitted: (message) {
                          // Handle the received message
                          print('Received Message: $message');
                          Navigator.pop(context);
                        },
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Cancel'),
                        ),
                        // You can add more actions as needed
                      ],
                    );
                  },
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Store Dialogue"),
                      content: TextField(
                        decoration: InputDecoration(labelText: 'Enter your dialogue'),
                        onSubmitted: (dialogue) {
                          // Handle storing the dialogue
                          storeDialogue(dialogue);
                          Navigator.pop(context);
                        },
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            // Handle storing the dialogue
                            Navigator.pop(context);
                          },
                          child: Text('Store'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Add New Step"),
                content: TextField(
                  decoration: InputDecoration(labelText: 'Step Description'),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      // Handle the action when the user adds a new step
                      Navigator.pop(context);
                    },
                    child: Text('Add'),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
