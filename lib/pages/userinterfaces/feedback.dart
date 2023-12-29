import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:loginui/pages/authenauthor/config.dart';
import 'package:loginui/pages/userinterfaces/home.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({Key? key}) : super(key: key);

  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  final _formKey = GlobalKey<FormState>();
  String _feedback = '';
  double _rating = 0;

  Future<void> sendFeedback(String feedback, String user_id) async {
    final response = await http.post(
      Uri.parse(sendfeedback),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'feedback': feedback,
        'user_id': user_id,
      }),
    );

    if (response.statusCode == 200) {
      // Feedback submitted successfully
      print('Feedback submitted successfully');
    } else {
      // Handle error if the request fails
      print('Failed to submit feedback. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Feedback'),
      backgroundColor: Color.fromARGB(255, 183, 224, 245),
      ),
      backgroundColor: Color.fromARGB(255, 219, 237, 246),
      body:
       Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text('Please let us know your FeedBack!'),
              const SizedBox(height: 16.0),
              TextFormField(
                validator: (value) =>
                    value!.isEmpty ? 'Feedback cannot be empty' : null,
                onSaved: (value) => setState(() => _feedback = value!),
                decoration: InputDecoration(
                  labelText: 'Feedback',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),
              Text('Rate your experience:'),
              const SizedBox(height: 8.0),
              RatingBar.builder(
                initialRating: _rating,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemSize: 40.0,
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color:  Colors.blue,
                ),
                onRatingUpdate: (rating) {
                  setState(() {
                    _rating = rating;
                  });
                },
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
              if (_formKey.currentState!.validate()) {
                 _formKey.currentState!.save();
                //  sendFeedback(_feedback, user_id);
                // Show a confirmation message or navigate to another page
                }
                 },
                style: ElevatedButton.styleFrom(
                primary: Colors.blue, // background color
                onPrimary: Colors.white, // text color
               ),
               child: Text('Submit Feedback'),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
