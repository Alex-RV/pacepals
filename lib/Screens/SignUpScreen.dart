import 'dart:ui';
import 'package:pacepals/globals.dart' as globals;
import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:pacepals/Screens/BottomNavbar.dart';
import 'package:pacepals/api/cfg/def.dart';
import 'package:pacepals/api/cfg/set_public.dart';
import 'package:pacepals/api/login/auth.dart';
import 'HomeScreen.dart';
import 'SignInScreen.dart';
import 'package:pacepals/api/login/signup.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController fullnameController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void _handleLogin() async {
    String email = nameController.text;
    String password = passwordController.text;
    String fullname = fullnameController.text;
    try {
      var resSignup = await apiLoginSignup(AILoginSignup(email, password));
      if (!resSignup.ok) {
        throw resSignup.error;
      }
      var resSignIn = await apiLoginAuth(AILoginAuth(email, password));
      if (!resSignIn.ok) {
        throw resSignIn.error;
      }
      // var resSetImg = await apiConfigSetPublic(AIConfigSetPublic(resSignIn.sid,
      //     UserPublicConfig(fullname, "", "assets/profileDefaultPicture.svg")));
      // if (!resSetImg.ok) {
      //   throw resSetImg.error;
      // }
      globals.uid = resSignIn.uid;
      globals.sid = resSignIn.sid;
      globals.fullname = fullname;
      globals.email = email;
      globals.isLoggedIn = true;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => BottomNavBar()),
      );
    } catch (e) {
      print('Something went wront $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Something went wrong $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Image.asset(
        "assets/pacepalsBackground.png",
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.cover,
      ),
      ClipRRect(
        // Clip it cleanly.
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
              color: Color.fromARGB(255, 52, 52, 52).withOpacity(0.4),
              alignment: Alignment.center,
              child: Scaffold(
                  backgroundColor: Colors.transparent,
                  body: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(10),
                              child: const Text(
                                'Sign Up',
                                style: TextStyle(
                                    fontSize: 24, color: Colors.white),
                              )),
                          // FullName TextField
                          Container(
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                              controller: fullnameController,
                              style: const TextStyle(
                                color: Colors.white, // text color
                              ),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor:
                                    const Color.fromARGB(136, 75, 75, 75),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide:
                                      const BorderSide(color: Colors.white),
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                        color: Color.fromARGB(227, 2, 0, 0))),
                                labelText: 'Full Name',
                                labelStyle: const TextStyle(
                                  color:
                                      Colors.white, // label color when focused
                                ),
                              ),
                            ),
                          ),
                          // User Name Text Field
                          Container(
                            padding: const EdgeInsets.all(10),
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                              controller: nameController,
                              style: const TextStyle(
                                color: Colors.white, // text color
                              ),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor:
                                    const Color.fromARGB(136, 75, 75, 75),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide:
                                      const BorderSide(color: Colors.white),
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                        color: Color.fromARGB(227, 2, 0, 0))),
                                labelText: 'Email',
                                labelStyle: const TextStyle(
                                  color:
                                      Colors.white, // label color when focused
                                ),
                              ),
                            ),
                          ),
                          // Password Text Field
                          Container(
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                              obscureText: true,
                              controller: passwordController,
                              style: const TextStyle(
                                color: Colors.white, // text color
                              ),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor:
                                    const Color.fromARGB(136, 75, 75, 75),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide:
                                      const BorderSide(color: Colors.white),
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                        color: Color.fromARGB(227, 2, 0, 0))),
                                labelText: 'Password',
                                labelStyle: const TextStyle(
                                  color:
                                      Colors.white, // label color when focused
                                ),
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              String username = nameController.text.trim();
                              String password = passwordController.text.trim();
                              if (_formKey.currentState!.validate()) {
                                _handleLogin();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Processing Data')),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF1DB954),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 10),
                            ),
                            child: const Text(
                              'Sign Up',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),

                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignInScreen()),
                              );
                            },
                            child: Text(
                              "Already have an account, Sign In",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                shadows: <Shadow>[
                                  Shadow(
                                    offset: Offset(1.0, 1.0),
                                    blurRadius: 3.0,
                                    color: Colors.black.withOpacity(0.3),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )))),
        ),
      ),
    ]);
  }
}
