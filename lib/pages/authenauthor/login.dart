import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loginui/pages/admin/adminpage.dart';
import 'package:loginui/pages/authenauthor/config.dart';
import 'package:lottie/lottie.dart';
import 'package:loginui/pages/userinterfaces/home.dart';
import 'package:loginui/pages/authenauthor/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

   class UserModel{
    static String? email;
    static String? fname;
    static String? lname;
    static String? phone;
    static String? birthdate;
    static String? gender;
   }
class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: mylogin(),
    );
  }
}
class mylogin extends StatefulWidget {
  @override
  _myloginState createState() => _myloginState();
}

class _myloginState extends State<mylogin> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final _formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isHidden = true;

  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    super.initState();
    initSharedPref();
    email = TextEditingController();
    password = TextEditingController();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 9),
    )..repeat();
  }
  late SharedPreferences prefs;
    bool _isNotValidate = false;
  void initSharedPref() async{
    prefs = await SharedPreferences.getInstance();
  }
  void loginUser() async{
    if(email.text.isNotEmpty && password.text.isNotEmpty){

      var reqBody = {
        "email":email.text,
        "password":password.text,
      };
      
      var response = await http.post(Uri.parse(login),
          headers: {"Content-Type":"application/json"},
          body: jsonEncode(reqBody)
      );
         if (response.statusCode == 200) {
        //Handle successful login response
        final responseData = json.decode(response.body);
        final bool isAdmin = responseData['isAdmin'];
         var myToken = responseData['token'];
          prefs.setString('token', myToken);
        if(isAdmin == true){
          Navigator.push(context, MaterialPageRoute(builder: (_)=>MyApp()));

        }
        else {
            var myToken = responseData['token'];
          prefs.setString('token', myToken);
           Navigator.push(context, MaterialPageRoute(builder: (_)=>MyWidget()));
        }
        }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Stack(
                  children: [
                    RotationTransition(
                      turns: _controller,
                      child: Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(90),
                            topRight: Radius.circular(120),
                            bottomLeft: Radius.circular(160),
                            bottomRight: Radius.circular(170),
                          ),
                          boxShadow: [
                            BoxShadow(
                              offset: const Offset(25, -15),
                              color: const Color(0xFF3273ef).withOpacity(0.1),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 150,
                      width: 250,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(90),
                          topRight: Radius.circular(120),
                          bottomLeft: Radius.circular(160),
                          bottomRight: Radius.circular(170),
                        ),
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color.fromARGB(255, 212, 226, 243),
                            Color.fromARGB(255, 168, 188, 236),
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(25, -15),
                            color: const Color(0xFF3273ef).withOpacity(0.1),
                          ),
                        ],
                      ),
                      child: LottieBuilder.asset("assets/Animation.json"),
                    ),
                  ],
                ),
              ),
              Text(
                "Hello There..",
                style: GoogleFonts.yesevaOne(
                  textStyle: const TextStyle(
                    fontSize: 20,
                    color: Colors.black26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Text(
                "Welcome Back",
                style: GoogleFonts.yesevaOne(
                  textStyle: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: email,
                        validator: (value) {
                          if (!RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value.toString())) {
                            return "Please enter a valid Email";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          labelText: "Email",
                          prefixIcon: Icon(
                            Icons.email_rounded,
                            color: Colors.purple,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: password,
                        validator: (value) {
                          if (password.text.isEmpty) {
                            return "Please enter a valid password";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          labelText: "Password",
                          suffixIcon: IconButton(
                            icon: isHidden
                                ? const Icon(Icons.visibility_off)
                                : const Icon(Icons.visibility),
                            onPressed: () {
                              setState(() {
                                isHidden = !isHidden;
                              });
                            },
                          ),
                          prefixIcon: const Icon(
                            Icons.lock_rounded,
                            color: Colors.purple,
                          ),
                        ),
                        obscureText: isHidden,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      MaterialButton(
                        color: Colors.purple,
                        minWidth: 65,
                        height: 45,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 100, vertical: 20),
                        onPressed: () => 
                        {
                        if(_formKey.currentState!.validate())
                        loginUser() 
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 60),
                        child: Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  height: 2,
                                  color: Colors.black45,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text(
                                "OR",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Container(
                                  height: 2,
                                  color: Colors.black45,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignUp()),
                  );
                },
                child: const Text(
                  'Sign Up',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
       ),
    );
  }
}