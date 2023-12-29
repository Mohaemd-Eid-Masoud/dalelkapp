import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:loginui/pages/authenauthor/login.dart';
import 'package:loginui/pages/authenauthor/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  SignUpState createState() => SignUpState();
}

class SignUpState extends State<SignUp> {

  List<String> _options = ['Male', 'Female'];
  String selectedGender = '';
  String selectedRole = '';
  bool obscureText = true;
  final _formKey = GlobalKey<FormState>();
  static TextEditingController emailController = TextEditingController();
  static TextEditingController passwordController = TextEditingController();
  TextEditingController fNameController = TextEditingController();
  TextEditingController lNameController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();
  TextEditingController phonenum=TextEditingController();
  
  bool _isNotValidate = false;
late SharedPreferences prefs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initSharedPref();
  }

  void initSharedPref() async{
    prefs = await SharedPreferences.getInstance();
  }
  void registerUser() async{
    if(emailController.text.isNotEmpty && passwordController.text.isNotEmpty){

      var regBody = {
        "firstname":fNameController.text,
        "lastname":lNameController.text,
        "phone":phonenum.text,
        "birthdate":birthDateController.text,
        "email":emailController.text,
        "password":passwordController.text,
        "gender":selectedGender
      };

      var response = await http.post(Uri.parse(registration),
      headers: {"Content-Type":"application/json"},
      body: jsonEncode(regBody)
      );

      var jsonResponse = jsonDecode(response.body);

      print(jsonResponse['status']);

      if(jsonResponse['status']){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginView()));
      }else{
        print("SomeThing Went Wrong");
      }
    }else{
      setState(() {
        _isNotValidate = true;
      });
    }
  }

  void _showSnackBar(String message, BuildContext context) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _toggleObscureText() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Container(
          padding: const EdgeInsets.all(12),
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      alignment: Alignment.center,
                      child: LottieBuilder.asset(
                        "assets/Animation.json",
                        height: 212,
                      ),
                    ),
                  ),
                  Container(height: 10),
                  Text(
                    "sign up",
                    style: GoogleFonts.yesevaOne(
                      textStyle: const TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),),
                  ),
                  Container(height: 10),
                  Text(
                    "Create an account",
                    style: GoogleFonts.yesevaOne(
                      textStyle: const TextStyle(
                        fontSize: 20,
                        color: Colors.black38,
                        fontWeight: FontWeight.bold,
                      ),),
                  ),
                  Container(height: 10),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "enter your name";
                              }
                            },
                            controller: fNameController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(
                                Icons.person,
                              ),
                              prefixIconColor: Colors.purple,
                              hintText: "Enter Your First Name",
                              hintStyle: GoogleFonts.yesevaOne(
                                textStyle: const TextStyle(
                                  fontSize: 10,
                                  color: Colors.black38,
                                  fontWeight: FontWeight.bold,
                                ),),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 2, horizontal: 12),
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 255, 255, 255)),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide:
                                    const BorderSide(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "enter your name";
                              }
                            },
                            controller: lNameController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(
                                Icons.person,
                              ),
                              prefixIconColor: Colors.purple,
                              hintText: "Enter Your Last Name",
                              hintStyle: GoogleFonts.yesevaOne(
                                textStyle: const TextStyle(
                                  fontSize: 10,
                                  color: Colors.black38,
                                  fontWeight: FontWeight.bold,
                                ),),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 2, horizontal: 12),
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 255, 255, 255)),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide:
                                    const BorderSide(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(height: 10),
                  TextFormField(
                    controller: emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Plz enter email";
                      }
                      if (!RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value)&&!RegExp(r"01[0-5]\d{8}").hasMatch(value)) {
                        return "plz enter a valid email address";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.email),
                      prefixIconColor: Colors.purple,
                      hintText: "Enter Your Email",
                      hintStyle:
                      GoogleFonts.yesevaOne(
                        textStyle: const TextStyle(
                          fontSize: 10,
                          color: Colors.black38,
                          fontWeight: FontWeight.bold,
                        ),),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 2, horizontal: 12),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 255, 255, 255)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                  Container(height: 10),
                  TextFormField(
                    controller: passwordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter a password";
                      }
                      if (value.length <= 4) {
                        return "password should be more than 4 char";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock),
                      suffix: IconButton(
                        icon: obscureText
                            ? const Icon(Icons.visibility_off,color: Colors.black38,)
                            : const Icon(Icons.visibility,color: Colors.black38,),
                        onPressed: _toggleObscureText,
                      ),
                      prefixIconColor: Colors.purple,
                      hintText: "Enter Your Password",
                      hintStyle:
                      GoogleFonts.yesevaOne(
                        textStyle: const TextStyle(
                          fontSize: 10,
                          color: Colors.black38,
                          fontWeight: FontWeight.bold,
                        ),),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 1, horizontal: 12),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 255, 255, 255)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(color: Colors.white),
                      ),
                    ),
                    obscureText: obscureText,
                  ),
                  Container(height: 10),
                  TextFormField(
                    controller: birthDateController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "enter your birthDate";
                      }
                    },
                    keyboardType: TextInputType.datetime,
                    readOnly:
                        true, // Make the field read-only to prevent manual text input
                    onTap: () async {
                      DateTime? selectedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                      );
                      if (selectedDate != null) {
                        String formattedDate =
                            "${selectedDate.day}-${selectedDate.month}-${selectedDate.year}";
                        birthDateController.text = formattedDate;
                      }
                    },
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.date_range),
                      prefixIconColor: Colors.purple,
                      hintText: "Enter Your birthDate",
                      hintStyle:
                      GoogleFonts.yesevaOne(
                        textStyle: const TextStyle(
                          fontSize: 12,
                          color: Colors.black38,
                          fontWeight: FontWeight.bold,
                        ),),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 2, horizontal: 12),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 255, 255, 255)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                  Container(height: 10,),
                  TextFormField(
                    controller: phonenum,
                    keyboardType: TextInputType.phone,
                    validator:  (value) {
                      if(value!.length<11){
                        return "invalid number";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.phone),
                    prefixIconColor: Colors.purple,
                    hintText: "phone number",
                    hintStyle:
                    GoogleFonts.yesevaOne(
                      textStyle: const TextStyle(
                        fontSize: 12,
                        color: Colors.black38,
                        fontWeight: FontWeight.bold,
                      ),),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 2, horizontal: 12),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 255, 255, 255)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(color: Colors.white),
                    ),
                  ),),
                  Container(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Gender",
                          style: GoogleFonts.yesevaOne(
                            textStyle: const TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),)),
                        flex: 2,
                      ),
                      Expanded(
                        flex: 4,
                        child: ListTile(
                          contentPadding: const EdgeInsets.only(right: 17),
                          title: Text(
                            'Male',
                            style: GoogleFonts.yesevaOne(
                              textStyle: const TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),),
                            textAlign: TextAlign.left,
                          ),
                          leading: Radio<String>(
                            value: 'Male',
                            groupValue: selectedGender,
                            onChanged: (value) {
                              setState(() {
                                selectedGender = value!;
                              });
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: ListTile(
                          contentPadding: const EdgeInsets.only(right: 17),
                          title:  Text('Female',
                              style: GoogleFonts.yesevaOne(
                                textStyle: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),)),
                          leading: Radio<String>(
                            value: 'Female', // Fixed typo here
                            groupValue: selectedGender,
                            onChanged: (value) {
                              setState(() {
                                selectedGender = value!;
                              });
                            },
                          ),
                        ),
                      ),
                    ],),
                  
                ],
              ),
              Container(height: 12),
              Center(
                child: Container(
                    width: 300,
                    child: MaterialButton(
                      height: 45,
                      minWidth: 60,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                        side: const BorderSide(color: Colors.white),
                      ),
                      color: Colors.purple,
                      textColor: Colors.white,
                      onPressed: () async {
                        if(_formKey.currentState!.validate())
                        registerUser();
                      },

                      child: Text(
                        "Sign up",style: GoogleFonts.yesevaOne(
                        textStyle:  TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),)
                      ),
                    )
                ),
              ),
              Container(height: 12),
              Container(
                margin: const EdgeInsets.only(top: 15),
                height: 30,
              ),
            ],
          ),
         ),
       ),
      ); 
    }
  }
