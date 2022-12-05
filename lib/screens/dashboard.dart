import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:univoffst/resources/auth_methods.dart';
import 'package:univoffst/screens/homepage.dart';
import 'package:univoffst/screens/login.dart';

class DashBoard extends StatefulWidget {
  final String uid;
  const DashBoard({Key? key, required this.uid}) : super(key: key);

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  var userData;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    print(widget.uid);
    getData();
  }

  getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      userData = (await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .get());
      setState(() {});
    } catch (e) {
      print(e);
    }
    setState(() {
      isLoading = false;
      // Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.blueAccent,
              title: Text(
                userData['name'],
                style: TextStyle(color: Colors.white),
              ),
              centerTitle: true,
              actions: [
                popUpMenu(context),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.grey,
                    backgroundImage: NetworkImage(
                      userData['photoUrl'],
                    ),
                    radius: 60,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(
                      top: 5,
                    ),
                    child: Text(
                      userData['email'],
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(
                      top: 5,
                    ),
                    child: Text(
                      userData['age'],
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => HomePage()));
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
                        'View Universities',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}

PopupMenuButton<int> popUpMenu(BuildContext context) {
  return PopupMenuButton(
    color: Colors.grey.shade300,
    itemBuilder: (context) => [
      const PopupMenuItem<int>(
        value: 1,
        child: Text(
          'Signout',
          style: TextStyle(color: Colors.black),
        ),
      ),
    ],
    onSelected: (item) => {
      SelectedItem(
        context,
        item,
      ),
    },
  );
}

void SelectedItem(BuildContext context, int item) async {
  switch (item) {
    case 1:
     SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove('email');
      AuthMethods().signOut();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: ((context) => LoginPage())));
      break;
  }
}
