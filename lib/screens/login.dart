// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:univoffst/resources/auth_methods.dart';
import 'package:univoffst/screens/createProfile.dart';
import 'package:univoffst/screens/dashboard.dart';
import 'homepage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;
  late String error = 'null2';
  bool hidepass = true;
  bool spinner = false;
  late String user;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: spinner,
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  height: 360,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/background.png'),
                        fit: BoxFit.fill),
                  ),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        left: 40,
                        width: 80,
                        height: 200,
                        child: Container(
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/light-1.png'),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 160,
                        width: 80,
                        height: 150,
                        child: Container(
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/light-2.png'),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 40,
                        top: 30,
                        width: 80,
                        height: 150,
                        child: Container(
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/clock.png'),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        child: Container(
                          margin: EdgeInsets.only(top: 50),
                          child: Center(
                              child: Text(
                            'Login',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(30.0),
                  child: Column(
                    children: [
                      showAlert(),
                      Container(
                        padding: EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromRGBO(140, 148, 251, 0.4),
                                blurRadius: 20.0,
                              )
                            ]),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Colors.grey.shade100,
                                  ),
                                ),
                              ),
                              child: TextField(
                                onChanged: (value) {
                                  email = value;
                                },
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Email',
                                  hintStyle: TextStyle(
                                    color: Colors.grey[500],
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(8.0),
                              child: TextField(
                                onChanged: (value) {
                                  password = value;
                                },
                                obscureText: hidepass,
                                decoration: InputDecoration(
                                  suffixIcon: hidepass == true
                                      ? IconButton(
                                          icon: Icon(Icons.visibility_off),
                                          onPressed: () {
                                            setState(() {
                                              hidepass = !hidepass;
                                            });
                                          },
                                        )
                                      : IconButton(
                                          icon: Icon(Icons.visibility),
                                          onPressed: () {
                                            setState(() {
                                              hidepass = !hidepass;
                                            });
                                          },
                                        ),
                                  border: InputBorder.none,
                                  hintText: 'Password',
                                  hintStyle: TextStyle(
                                    color: Colors.grey[500],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 40.0,
                      ),
                      GestureDetector(
                        onTap: () async {
                          setState(() {
                            spinner = true;
                          });
                          try {
                            user = await AuthMethods().loginUser(
                                email: email, password: password) ;
                            print(user);
                            if (user == "success") {
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              prefs.setString('email', email);
                              // ignore: use_build_context_synchronously
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (context) {
                                return DashBoard(
                                  uid: FirebaseAuth.instance.currentUser!.uid,
                                );
                              }));
                            } else {
                              setState(() {
                                error = 'null';
                                showAlert();
                              });
                            }
                            setState(() {
                              spinner = false;
                            });
                          } catch (er) {
                            setState(() {
                              spinner = false;
                              error = error;
                            });
                          }
                        },
                        child: Container(
                          height: 50.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(
                              colors: const [
                                Color.fromRGBO(140, 148, 251, 1),
                                Color.fromRGBO(140, 148, 251, 0.6),
                              ],
                            ),
                          ),
                          child: Center(
                              child: Text(
                            'Login',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17.0,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                        ),
                      ),
                      SizedBox(
                        height: 40.0,
                      ),
                      GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return CreateProfile();
                            }));
                          },
                          child: Text(
                            'New User ? SIGNUP',
                            style: TextStyle(
                              color: Color.fromRGBO(140, 148, 251, 1),
                            ),
                          )),
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

  Widget showAlert() {
    if (error=='null') {
      return Container(
        color: Colors.yellow,
        width: double.infinity,
        padding: EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Icon(
                Icons.error,
              ),
            ),
            Expanded(
              child: Text(
                'User not found',
                maxLines: 4,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(2.0),
              child: IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    setState(() {
                      error = 'null2';
                    });
                  }),
            ),
          ],
        ),
      );
    }
    return SizedBox(
      height: 0.0,
    );
  }
}
