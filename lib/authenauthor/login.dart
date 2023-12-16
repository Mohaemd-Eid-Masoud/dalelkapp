import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:loginui/admin/adminpage.dart';
import 'package:loginui/classes/fadeanimation.dart';
import 'package:loginui/classes/hex_color.dart';
import 'package:loginui/classes/nav-drawer.dart';
import 'package:loginui/authenauthor/forgot_password.dart';
import 'package:loginui/authenauthor/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'config.dart';
import 'package:loginui/userinterfaces/home.dart';
enum FormData {
  Email,
  password,
}
class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  late SharedPreferences prefs;
    bool _isNotValidate = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initSharedPref();
  }

  void initSharedPref() async{
    prefs = await SharedPreferences.getInstance();

  
  }
  void loginUser() async{
    if(emailController.text.isNotEmpty && passwordController.text.isNotEmpty){

      var reqBody = {
        "email":emailController.text,
        "password":passwordController.text,
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
          Navigator.push(context, MaterialPageRoute(builder: (_)=>MyApp(token: myToken)));
        }
        else {
            var myToken = responseData['token'];
          prefs.setString('token', myToken);
           Navigator.push(context, MaterialPageRoute(builder: (_)=>MyWidget(token: myToken)));
        }
        }
     
      // var jsonResponse = jsonDecode(response.body);
      // if(jsonResponse['status']){
      //     var myToken = jsonResponse['token'];
      //     prefs.setString('token', myToken);
      //     Navigator.push(context, MaterialPageRoute(builder: (context)=>MyWidget(token: myToken)));
      // }else{print("Something went wrong");
      }

    }
  

  Color enabled = Color(0xFF02457a);
  Color enabledtxt = Colors.white;
  Color deaible = const Color.fromARGB(255, 203, 202, 202);
  Color backgroundColor = Color.fromARGB(255, 85, 148, 204);
  bool ispasswordev = true;
  FormData? selected;

  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Container(
        decoration: BoxDecoration(
          color: Color(0xffd6ebee),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FadeAnimation(
                  delay: 0.8,
                  child: Image.asset("assets/logo_5-removebg.png", height: 300),
                ),
                Center(
                  child: Card(
                    elevation: 5,
                    color: Color(0xff97cadb),
                    child: Container(
                      height: 300,
                      padding: EdgeInsets.all(40.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: 12,
                          ),
                          FadeAnimation(
                            delay: 1,
                            child: const Text(
                              "Please sign in to continue",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Color.fromARGB(255, 16, 79, 131),
                                  letterSpacing: 0.5),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          FadeAnimation(
                            delay: 1,
                            child: Container(
                              width: 300,
                              height: 40,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.0),
                                  color: selected == FormData.Email
                                  ?  enabled
                                  : backgroundColor),
                              padding: const EdgeInsets.all(5.0),
                              child: TextField(
                                controller: emailController,
                                onTap: () {
                                  setState(() {
                                    selected = FormData.Email;
                                  });
                                },
                                decoration: InputDecoration(
                                  enabledBorder: InputBorder.none,
                                  border: InputBorder.none,
                                  prefixIcon: Icon(
                                    Icons.email_outlined,
                                    color: selected == FormData.Email
                                        ? enabledtxt
                                        : deaible,
                                    size: 20,
                                  ),
                                  hintText: 'Email',
                                  hintStyle: TextStyle(
                                      color: selected == FormData.Email
                                          ? enabledtxt
                                          : deaible,
                                      fontSize: 12),
                                ),
                                textAlignVertical: TextAlignVertical.center,
                                style: TextStyle(
                                    color: selected == FormData.Email
                                        ? enabledtxt
                                        : deaible,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          FadeAnimation(
                            delay: 1,
                            child: Container(
                              width: 300,
                              height: 40,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.0),
                                  color: selected == FormData.password
                                      ? enabled
                                      : backgroundColor),
                              padding: const EdgeInsets.all(5.0),
                              child: TextField(
                                controller: passwordController,
                                onTap: () {
                                  setState(() {
                                    selected = FormData.password;
                                  });
                                },
                                decoration: InputDecoration(
                                    enabledBorder: InputBorder.none,
                                    border: InputBorder.none,
                                    prefixIcon: Icon(
                                      Icons.lock_open_outlined,
                                      color: selected == FormData.password
                                          ? enabledtxt
                                          : deaible,
                                      size: 20,
                                    ),
                                    suffixIcon: IconButton(
                                      icon: ispasswordev
                                          ? Icon(
                                              Icons.visibility_off,
                                              color:
                                                  selected == FormData.password
                                                      ? enabledtxt
                                                      : deaible,
                                              size: 20,
                                            )
                                          : Icon(
                                              Icons.visibility,
                                              color:
                                                  selected == FormData.password
                                                      ? enabledtxt
                                                      : deaible,
                                              size: 20,
                                            ),
                                      onPressed: () => setState(
                                          () => ispasswordev = !ispasswordev),
                                    ),
                                    hintText: 'Password',
                                    hintStyle: TextStyle(
                                        color: selected == FormData.password
                                            ? enabledtxt
                                            : deaible,
                                        fontSize: 12)),
                                obscureText: ispasswordev,
                                textAlignVertical: TextAlignVertical.center,
                                style: TextStyle(
                                    color: selected == FormData.password
                                        ? enabledtxt
                                        : deaible,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12),
                              ),
                              // backgroundColor:Color(0xff018abe)
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          FadeAnimation(
                            delay: 1,
                            child: TextButton(
                                onPressed: ()  {
                                  loginUser();
                                },
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                    color: Colors.white,
                                    letterSpacing: 0.5,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                style: TextButton.styleFrom(
                                    backgroundColor: Color(0xff001b4b),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 14.0, horizontal: 80),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.0)))),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                //End of Center Card
                //Start of outer card
                const SizedBox(
                  height: 20,
                ),
                FadeAnimation(
                  delay: 1,
                  child: GestureDetector(
                    onTap: (() {
                      Navigator.pop(context);
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return ForgotPasswordScreen();
                      }));
                    }),
                    child: Text("Can't Log In?",
                        style: TextStyle(
                          color: Colors.black,
                          letterSpacing: 0.5,
                        )),
                  ),
                ),
                SizedBox(height: 10),
                FadeAnimation(
                  delay: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text("Don't have an account? ",
                          style: TextStyle(
                            color: Colors.grey,
                            letterSpacing: 0.5,
                          )),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return SignupScreen();
                          }));
                        },
                        child: Text("Sign up",
                            style: TextStyle(
                                color: const Color.fromARGB(255, 50, 35, 35)
                                    .withOpacity(0.9),
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                                fontSize: 14)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
