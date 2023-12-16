import 'package:flutter/material.dart';
import 'package:loginui/authenauthor/config.dart';
import 'package:loginui/admin/nav-drawer.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
void main() {
  runApp(MyApp(token: "your_token_here")); // Replace "your_token_here" with an actual token
}

class StepData {
 late String title;
 late String description;
 late List<String> content;

  StepData({required this.title, required this.description, required this.content});

Map<String,dynamic> toJson(){
return {
  'title':title,
  'description':description,
  'content':content
};
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

class AdminPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
 List<StepData> steps = [];
  TextEditingController titleController = new TextEditingController();
    TextEditingController descriptionController = new TextEditingController();
  late List<TextEditingController> contentControllers;
Future<void> addcontent(String title, String description, List<String> content) async {
  final response = await http.post(
    Uri.parse(addContent),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'title': titleController.text, 'description': descriptionController.text, 'content': content}),
  );

  if (response.statusCode == 200) {
    print('Step added successfully');
    
  } else {
    print('Failed to add step. Status code: ${response.statusCode}');
  }
}

  @override
  void initState() {
    super.initState();
     titleController = TextEditingController();
    descriptionController = TextEditingController();
    contentControllers = [TextEditingController()];
    _getSteps();
  }

  Future<void> _getSteps() async {
    final response = await http.get(Uri.parse(getContent));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      setState(() {
        steps = data
            .map((step) => StepData(
                  title: step['title'],
                  description: step['description'],
                  content: List<String>.from(step['content']),
                ))
            .toList();
      });
    } else {
      print('Failed to get steps. Status code: ${response.statusCode}');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer :NavDrawer(),    
      appBar: AppBar(
        title: Text('Dalelk Admin Panel',),
      ),
      body: ListView.builder(
        itemCount: steps.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(steps[index].title),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(steps[index].description),
                Text("Step: ${steps[index].content}"),
              ],
            ),
            onTap: () {
              _editStep(index);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addStep,
        tooltip: 'Add Content',
        child: Icon(Icons.add),
      ),
    );
  }

  void _addStep() {
    showDialog(
      context: context,
      builder: (context) {
        String title = '';
        String description = '';
        List<String> content = [];

        return StatefulBuilder(
          builder: (context, setState) {
            return SingleChildScrollView(
            child: AlertDialog(
              title: Text('Add Content'),
              content: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(labelText: 'Title'),
                    controller: titleController,
                    onChanged: (value) {
                      title = value;
                    },
                  ),
                  TextField(
                    decoration: InputDecoration(labelText: 'Description'),
                    controller: descriptionController,
                    onChanged: (value) {
                      description = value;
                    },
                  ),
                  // Display existing content text fields
                  for (int i = 0; i < content.length; i++)
                    TextField(
                      decoration: InputDecoration(labelText: 'Step'),
                      controller: TextEditingController(text: content[i]),
                      onChanged: (value) {
                        content[i] = value;
                      },
                    ),
                  // Add new content text field dynamically
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        content.add('');
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
                      steps.add(StepData(title: title, description: description, content: content));
                    });
                    Navigator.pop(context);
                  },
                  child: Text('Add'),
                ),
              ],
            ));
          },
        );
      },
    );
  }

  void _editStep(int index) {
    showDialog(
      context: context,
      builder: (context) {
        String title = steps[index].title;
        String description = steps[index].description;
        List<String> content = steps[index].content;

        return StatefulBuilder(
          builder: (context, setState) {
            return SingleChildScrollView(
            child : AlertDialog(
              title: Text('Edit Content'),
              content: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(labelText: 'Title'),
                    controller: titleController,
                    onChanged: (value) {
                      title = value;
                    },
                  ),
                  TextField(
                    decoration: InputDecoration(labelText: 'Description'),
                    controller: descriptionController,
                    onChanged: (value) {
                      description = value;
                    },
                  ),
                  // Display existing content text fields
                  for (int i = 0; i < content.length; i++)
                    TextField(
                      decoration: InputDecoration(labelText: 'Step'),
                      controller: TextEditingController(text: content[i]),
                      onChanged: (value) {
                        content[i] = value;
                      },
                    ),
                  // Add new content text field dynamically
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        content.add('');
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
                      steps[index] = StepData(title: title, description: description, content: content);
                    });
                    Navigator.pop(context);
                  },
                  child: Text('Save'),
                ),
              ],
            ));
          },
        );
      },
    );
  }
}
