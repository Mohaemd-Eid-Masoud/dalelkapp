
import 'package:flutter/material.dart';
import 'package:loginui/classes/fadeanimation.dart';
import 'package:loginui/classes/hex_color.dart';
import 'package:loginui/authenauthor/login.dart';
import 'package:loginui/authenauthor/pin_code.dart';

enum FormData { phoneNumber }

class ForgotPasswordScreen extends StatefulWidget {
  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  Color enabled = Color.fromARGB(255, 140, 140, 150);
  Color enabledtxt = Colors.white;
  Color deaible = Colors.grey;
  Color backgroundColor = Color.fromARGB(255, 238, 235, 248);
  bool ispasswordev = true;

  FormData? selected;

  TextEditingController phonecontroller = new TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Color(0xffd6ebee)),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  elevation: 5,
                  color: Color.fromARGB(255, 152, 200, 238),
                  child: Container(
                    width: 400,
                    padding: EdgeInsets.all(40.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        FadeAnimation(
                          delay: 0.8,
                          child: Image.asset("assets/welcome.png"),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        // FadeAnimation(
                        //   delay: 1,
                        //   child: Container(
                        //     child: Text(
                        //       "Let us help you",
                        //       style: TextStyle(
                        //           color: Colors.white.withOpacity(0.9),
                        //           letterSpacing: 0.5),
                        //     ),
                        //   ),
                        // ),
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
                              color: selected == FormData.phoneNumber
                                  ? enabled
                                  : backgroundColor,
                            ),
                            padding: const EdgeInsets.all(5.0),
                            
                            child: TextField(
                              //  validator: (value) {
                              // if (value == null || value.isEmpty) {
                              // return 'Please enter your Phone Number';
                              // }
                              // return null;
                              // };
                              controller: phonecontroller,
                              onTap: () {
                                setState(() {
                                  selected = FormData.phoneNumber;
                                });
                              },
                              decoration: InputDecoration(
                                enabledBorder: InputBorder.none,
                                border: InputBorder.none,
                                prefixIcon: Icon(
                                  Icons.email_outlined,
                                  color: selected == FormData.phoneNumber
                                      ? enabledtxt
                                      : deaible,
                                  size: 20,
                                ),
                                hintText: 'Phone Number',
                                hintStyle: TextStyle(
                                    color: selected == FormData.phoneNumber
                                        ? enabledtxt
                                        : deaible,
                                    fontSize: 12),
                              ),
                              textAlignVertical: TextAlignVertical.center,
                              style: TextStyle(
                                  color: selected == FormData.phoneNumber
                                      ? enabledtxt
                                      : deaible,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        FadeAnimation(
                          delay: 1,
                          child: TextButton(
                              onPressed: () {
                                if(phonecontroller.text=="01005189543"){
                                Navigator.pop(context);
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (context) {
                                  return const PinCodeVerificationScreen(
                                    phoneNumber: '010XXXXXXXX',
                                  );
                                }));
                              }
                              },
                              child: Text(
                                "Continue",
                                style: TextStyle(
                                  color: Colors.white,
                                  letterSpacing: 0.5,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              style: TextButton.styleFrom(
                                  backgroundColor: Color(0xFF2697FF),
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

                //End of Center Card
                //Start of outer card
                SizedBox(
                  height: 20,
                ),

                FadeAnimation(
                  delay: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text("Want to try again? ",
                          style: TextStyle(
                            color: Color.fromARGB(255, 54, 53, 53),
                            letterSpacing: 0.5,
                          )),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return LoginScreen();
                          }));
                        },
                        child: Text("Sing in",
                            style: TextStyle(
                                color: const Color.fromARGB(255, 0, 0, 0)
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

