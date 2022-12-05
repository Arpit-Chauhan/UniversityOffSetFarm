// ignore_for_file: sort_child_properties_last, prefer_const_constructors

import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:univoffst/models/user.dart';
import 'package:univoffst/screens/dashboard.dart';
import 'package:univoffst/screens/homepage.dart';
import 'package:univoffst/screens/login.dart';

import '../components/form_textfield.dart';
import '../resources/auth_methods.dart';

class CreateProfile extends StatefulWidget {
  const CreateProfile({Key? key}) : super(key: key);

  @override
  _CreateProfileState createState() => _CreateProfileState();
}

class _CreateProfileState extends State<CreateProfile> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  bool _isLoading = false;
  late File? _image = null;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _ageController.dispose();
    _nameController.dispose();
  }

  void signUpUser() async {
    // set loading to true
    setState(() {
      _isLoading = true;
    });

    // signup user using our authmethodds
    String res = await AuthMethods().signUpUser(
      email: _emailController.text,
      password: _passwordController.text,
      file: _image!,
      age: _ageController.text,
      name: _nameController.text,
    );
    // if string returned is sucess, user has been created
    if (res == "success") {
      setState(() {
        _isLoading = false;
      });
      // navigate to the home screen
      print(FirebaseAuth.instance.currentUser!.uid);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: ((context) =>
                  DashBoard(uid: FirebaseAuth.instance.currentUser!.uid))));
    } else {
      setState(() {
        _isLoading = false;
      });
      // show the error
      // showLoadingBar(context, res);
    }
  }

  selectImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    // set state because we need to display the image we selected on the circle avatar
    File pathfile = File(pickedFile!.path);
    setState(() {
      _image = pathfile;
    });
  }

  @override
  Widget build(BuildContext context) {
    //AuthProvider authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Create Profile'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 40,
                ),
                Stack(
                  children: [
                    _image != null
                        ? CircleAvatar(
                            radius: 64,
                            backgroundImage: FileImage(_image!),
                            backgroundColor: Colors.grey,
                          )
                        : const CircleAvatar(
                            radius: 64,
                            backgroundImage: NetworkImage(
                                'https://i.stack.imgur.com/l60Hf.png'),
                            backgroundColor: Colors.grey,
                          ),
                    Positioned(
                      bottom: -10,
                      left: 80,
                      child: IconButton(
                        onPressed: selectImage,
                        icon: const Icon(Icons.add_a_photo),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                TextFieldInput(
                  hintText: 'Enter Full Name',
                  textInputType: TextInputType.text,
                  textEditingController: _nameController,
                ),
                const SizedBox(
                  height: 24,
                ),
                TextFieldInput(
                  hintText: 'Enter your email',
                  textInputType: TextInputType.emailAddress,
                  textEditingController: _emailController,
                ),
                const SizedBox(
                  height: 24,
                ),
                TextFieldInput(
                  hintText: 'Enter your password',
                  textInputType: TextInputType.text,
                  textEditingController: _passwordController,
                  isPass: true,
                ),
                const SizedBox(
                  height: 24,
                ),
                TextFieldInput(
                  hintText: 'Enter your age',
                  textInputType: TextInputType.number,
                  textEditingController: _ageController,
                ),
                const SizedBox(
                  height: 60,
                ),
                InkWell(
                  child: Container(
                    child: !_isLoading
                        ? const Text(
                            'Sign up',
                            style: TextStyle(color: Colors.white),
                          )
                        : const CircularProgressIndicator(
                            color: Colors.white,
                          ),
                    width: double.infinity,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: const ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                      ),
                      color: Colors.blue,
                    ),
                  ),
                  onTap: () {
                    if (_emailController.value != null &&
                        _ageController.value != null &&
                        _nameController.value != null &&
                        _passwordController.value != null &&
                        _image != null) {
                      signUpUser();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            '*Fill all fields',
                          ),
                        ),
                      );
                    }
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return LoginPage();
                      }));
                    },
                    child: Text(
                      'Have an account ? LOGIN',
                      style: TextStyle(
                        color: Color.fromRGBO(140, 148, 251, 1),
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
