import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';

import 'package:logger/logger.dart';
import 'package:flutter/material.dart';

import 'login.dart';
import 'model/profile.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();
  Profile profile = Profile(username: '' ,email: '', password: '');
  final Future<FirebaseApp> firebase = Firebase.initializeApp();

  final _emailController = TextEditingController();
  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();

  final register_log = Logger(
      printer: PrettyPrinter(
          methodCount: 0,
          errorMethodCount: 3,
          colors: true,
          printEmojis: true,
          printTime: false
  ));

  Future addUser(String userName, String email, String password) async {
    try {
      await FirebaseFirestore.instance.collection('users').add({
        'userName': userName,
        'email': email,
        'password': password,
      });
      register_log.i('User add to database');
      print('User added to database.');
    } catch (e) {
      register_log.e('Failed adding user to database $e');
      print('Error adding user to database: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: firebase,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(title: Text("Error")),
            body: Center(
              child: Text("${snapshot.error}"),
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                      Image.asset("assets/images/logo.png",
                          fit: BoxFit.contain),
                      SizedBox(height: 10),
                      Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // userName
                            TextFormField(
                              controller: _userNameController,
                              decoration: InputDecoration(
                                labelText: "Username",
                                prefixIcon: Icon(Icons.person),
                              ),
                              validator: RequiredValidator(
                                  errorText: "Please enter your username"),
                              onSaved: (String? username) {
                                profile.username = username!;
                              },
                            ),

                            // adding some space
                            SizedBox(height: 15),

                            // user Email
                            TextFormField(
                              controller: _emailController,
                              decoration: InputDecoration(
                                labelText: "Email",
                                prefixIcon: Icon(Icons.email),
                              ),
                              validator: MultiValidator([
                                RequiredValidator(
                                    errorText: "Please input your Email"),
                                EmailValidator(errorText: "Invalid format"),
                              ]),
                              keyboardType: TextInputType.emailAddress,
                              onSaved: (String? email) {
                                profile.email = email!;
                              },
                            ),

                            // adding some space
                            SizedBox(height: 15),

                            // user password
                            TextFormField(
                              controller: _passwordController,
                              decoration: InputDecoration(
                                labelText: "Password",
                                prefixIcon: Icon(Icons.lock),
                              ),
                              validator: RequiredValidator(
                                  errorText: "Please input your password"),
                              obscureText: true,
                              onSaved: (String? password) {
                                profile.password = password!;
                              },
                            ),

                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.pinkAccent),
                                  ),
                                  child: Text(
                                    "Register",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  onPressed: () async {
                                    if(_userNameController.text.isEmpty){
                                      register_log.w("User Username is empty");
                                    }
                                    else if(_emailController.text.isEmpty){
                                      register_log.w("User Email is empty");
                                    }
                                    else if (_passwordController.text.isEmpty){
                                      register_log.w("User Password is empty");
                                    }
                                    if (formKey.currentState!.validate()) {
                                      formKey.currentState!.save();
                                      try {
                                        await FirebaseAuth.instance
                                            .createUserWithEmailAndPassword(
                                          email: profile.email,
                                          password: profile.password,
                                        )
                                            .then((value) {
                                          addUser(
                                              _userNameController.text,
                                              _emailController.text,
                                              _passwordController.text);
                                          Fluttertoast.showToast(
                                            msg: "Created Account Successful",
                                            gravity: ToastGravity.CENTER,
                                          );
                                          register_log.i("Create Accrount Successful");
                                          formKey.currentState!.reset();
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  LoginScreen(),
                                            ),
                                          );
                                        });
                                      } on FirebaseAuthException catch (e) {
                                        Fluttertoast.showToast(
                                          msg: e.message!,
                                          gravity: ToastGravity.CENTER,
                                        );
                                        register_log.w(
                                            "Failed creating user account ${e.message}");
                                      }
                                    }
                                  },
                                ),
                              ),
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
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
