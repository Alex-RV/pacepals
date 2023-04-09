import 'dart:ui';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:flutter/material.dart';
import 'package:pacepals/api/cfg/get.dart';
import 'package:pacepals/api/login/auth.dart';
import 'SignUpScreen.dart';
import 'HomeScreen.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void _handleLogin() async {
    String email = nameController.text;
    String password = passwordController.text;

    try {
      var res = await apiLoginAuth(AILoginAuth(email, password));
      var data = await apiConfigGet(AIConfigGet(res.sid));
      var session = SessionManager();
      await session.set("uid", res.uid);
      await session.set("sid", res.sid);
      await session.set("fullname", data.publicConfig.name);
      await session.set("email", email);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } catch (e) {
      print('Something went wront $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Something went wrong: $e')),
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
                                'Sign in',
                                style: TextStyle(
                                    fontSize: 24, color: Colors.white),
                              )),
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
                              'Sign In',
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
                                    builder: (context) => SignUpScreen()),
                              );
                            },
                            child: Text(
                              "Don't have account, Sign Up",
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
