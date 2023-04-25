import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:logger/logger.dart';

import 'model/profile.dart';
import 'package:prototype/screen/findKafeHome.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  Profile profile = Profile(username: '', email: '', password: '');
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  final login_log = Logger(
      printer: PrettyPrinter(
          methodCount: 0,
          errorMethodCount: 3,
          colors: true,
          printEmojis: true,
          printTime: false
  ));


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
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: "Email",
                                prefixIcon: Icon(Icons.email),
                              ),
                              validator: MultiValidator([
                                RequiredValidator(
                                    errorText: "Please input your Email"),
                                EmailValidator(errorText: "Invalid format")
                              ]),
                              keyboardType: TextInputType.emailAddress,
                              onSaved: (String? email) {
                                profile.email = email!;
                              },
                            ),

                            SizedBox(height: 15),

                            TextFormField(
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
                                    "Login",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  onPressed: () async {
                                    if (formKey.currentState!.validate()) {
                                      formKey.currentState!.save();
                                      try {
                                        await FirebaseAuth.instance.signInWithEmailAndPassword(
                                          email: profile.email, 
                                          password: profile.password
                                        ).then((value){
                                           formKey.currentState!.reset();
                                            Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  FindKafeHome(),
                                            ),
                                          );
                                        });
                                      } on FirebaseAuthException catch (e) {
                                        Fluttertoast.showToast(
                                          msg: e.message!,
                                          gravity: ToastGravity.CENTER,
                                        );
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
