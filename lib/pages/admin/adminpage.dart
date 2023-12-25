import 'package:flutter/material.dart';
import 'package:loginui/pages/authenauthor/config.dart';
import 'package:loginui/pages/admin/nav-drawer.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp(
      token:
          "your_token_here")); // Replace "your_token_here" with an actual token
}

class StepData {
  late String? title;
  late String? description;
  late List<String> steps;
  StepData(
      {required this.title, required this.description, required this.steps});
  Map<String, dynamic> toJson() {
    return {'title': title, 'description': description, 'content': steps};
  }
  StepData.fromJson(Map<String,dynamic> json) {
    title = json['title'];
    description = json['description'];
    steps = json['content'];
  }
}

class MyApp extends StatelessWidget {
  final String token;

  const MyApp({required this.token, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AdminPage(),
    );
  }
}

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  static List<StepData> stepsData = [];
  @override
  void initState() {
    super.initState();
  setState(() {
    getSteps;
  });
  }

  Future<void> _addcontent(String title, String description, List<String> steps) async {
    final response = await http.post(
      Uri.parse(addContent),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'title': title, 'description':description, 'content': steps}),
    );
  
    if (response.statusCode == 200) {
      print('Step added successfully');
  
    } else {
      print('Failed to add step. Status code: ${response.statusCode}');
    }
  }

  Future<void> _editContent(String title, String description, List<String> steps) async {
    final response = await http.post(
      Uri.parse(editContent),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'title': title, 'description':description, 'content': steps}),
    );
  
    if (response.statusCode == 200) {
      print('Content added successfully');
  
    } else {
      print('Failed to add Content. Status code: ${response.statusCode}');
    }
  }
  static Future<List<StepData>?> getSteps() async {
  final response = await http.get(Uri.parse(getContent));
  if (response.statusCode == 200) {
    final dynamic responseData = jsonDecode(response.body);

    print('Response Body: $responseData');

    if (responseData != null &&
        responseData['content'] is List<dynamic>) {
      final List<dynamic> stepsList = responseData['content'];
      print('Success to get steps. Status code: ${response.statusCode}');
      return stepsData = stepsList
          .map((step) => StepData(
                title: step['title'],
                description: step['description'],
                steps: List<String>.from(step['content']),
              ))
          .toList();
    } else {
      print('Invalid response format or missing "content" key.');
      return null;
    }
  } else {
    print('Failed to get steps. Status code: ${response.statusCode}');
    return null; // Return null in case of failure
  }
}

  // variable to call and store future list of posts
    Future<List<StepData>?> postsFuture = getSteps();
  // function to display fetched data on screen
  Widget displayData(List<StepData> stepsData) {
  // ListView Builder to show data in a list
  return ListView.builder(
    itemCount: stepsData.length,
    itemBuilder: (context, index) {
      final post = stepsData[index];
      return GestureDetector(
        onTap: () {
           _editcontent(index);
          // Add your onTap action here
          // For example, you can navigate to a new screen or show a dialog
          print('Tapped on ${post.title}');
        },
      child: Container(
        color: Color.fromARGB(255, 250, 233, 255),
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        height: 100,
        width: double.maxFinite,
        child: Row(
          children: [
            Expanded(flex: 1, child: Image.asset("assets/img4.png")), // Fix typo in the asset path
            SizedBox(width: 10),
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(post.title ?? 'No Title'),
                  Text(post.description ?? 'No Description'),
                  Text('Steps: ${post.steps.join(", ")}'),
                ],
              ),
            ),
          ],
        ),
      ));
    },
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer :NavDrawer(),
      appBar: AppBar(
        title: const Text(
          'Dalelk Admin Panel',
          textAlign: TextAlign.center,
        ),
      ),
      body: Center(
      child: FutureBuilder<List<StepData>?>(
      future: postsFuture,
      builder: (context, snapshot) {
       if (snapshot.connectionState == ConnectionState.waiting) {
        return const CircularProgressIndicator();
      } else if (snapshot.hasData) {
        final stepdata = snapshot.data!;
        return displayData(stepdata);
      } else if (snapshot.hasError) {
        print("Error: ${snapshot.error}");
        return Text("Error: ${snapshot.error}");
      } else {
        return const Text("No data available");
      }
      },
      ),
      ),        
      floatingActionButton: FloatingActionButton(
        onPressed: _addContent,
        tooltip: 'Add Content',
        child: Icon(Icons.add),
      ),
    );
  }

  void _addContent() {
    showDialog(
      context: context,
      builder: (context) {
        String title = '';
        String description = '';
        List<String> steps = [];

        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return SingleChildScrollView(
              child: AlertDialog(
                title: const Text('Add Content'),
                content: Column(
                  children: [
                    TextFormField(
                      initialValue: title,
                      decoration: const InputDecoration(labelText: 'Title'),
                      onChanged: (value) {
                        title = value;
                      },
                    ),
                    TextFormField(
                      initialValue: description,
                      decoration: const InputDecoration(labelText: 'Description'),
                      onChanged: (value) {
                        description = value;
                      },
                    ),
                    // Display existing content text fields
                    for (int i = 0; i < steps.length; i++)
                      TextField(
                        controller: TextEditingController(text: steps[i]),
                        decoration: InputDecoration(
                          labelText: 'Step',
                          suffixIcon: IconButton(
                            onPressed: () {
                              setStateDialog(() {
                                steps.removeAt(i);
                              });
                            },
                            icon: Icon(Icons.delete_forever_rounded),
                          ),
                        ),
                        onChanged: (value) {
                          steps[i] = value;
                        },
                      ),
                    // Add new content text field dynamically
                    ElevatedButton(
                      onPressed: () {
                        setStateDialog(() {
                          steps.add('');
                        });
                      },
                      child: const Text('Add Step'),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        stepsData.add(StepData(
                            title: title,
                            description: description,
                            steps: steps));
                            _addcontent(
                             title,
                            description,
                            steps);
                            print(stepsData);

                      });
                      Navigator.pop(context);
                    },
                    child: const Text('Add'),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
  void _editcontent(int index) {
    showDialog(
      context: context,
      builder: (context) {
        String? title = stepsData[index].title;
        String? description = stepsData[index].description;
        List<String> steps = stepsData[index].steps;

        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return SingleChildScrollView(
              child: AlertDialog(
                title: Text('Edit Content'),
                content: Column(
                  children: [
                    TextFormField(
                      initialValue: title,
                      decoration: InputDecoration(labelText: 'Title'),
                      onChanged: (value) {
                        title = value;
                      },
                    ),
                    TextFormField(
                      initialValue: description,
                      decoration: InputDecoration(labelText: 'Description'),
                      onChanged: (value) {
                        description = value;
                      },
                    ),
                    // Display existing content text fields
                    for (int i = 0; i < steps.length; i++)
                      TextField(
                        controller: TextEditingController(text: steps[i]),
                        decoration: InputDecoration(
                          labelText: 'Step',
                          suffixIcon: IconButton(
                            onPressed: () {
                              setStateDialog(() {
                                steps.removeAt(i);
                              });
                            },
                            icon: const Icon(Icons.delete_forever_rounded),
                          ),
                        ),
                        onChanged: (value) {
                          steps[i] = value;
                        },
                      ),
                    // Add new content text field dynamically
                    ElevatedButton(
                      onPressed: () {
                        setStateDialog(() {
                          steps.add('');
                        });
                      },
                      child: Text('Add Step'),
                    ),
                  ],
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
                      setState(() {
                        _editContent(title!, description!, steps);
                        stepsData[index] = StepData(
                            title: title,
                            description: description,
                            steps: steps);
                      });
                      Navigator.pop(context);
                    },
                    child: Text('Save'),
                  ),
                ],
              ),
            );
          },
        );
      },
    );  
  }
  }