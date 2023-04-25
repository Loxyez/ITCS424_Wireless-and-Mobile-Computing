import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:prototype/screen/findKafeHome.dart';

class UserProfile extends StatefulWidget {


  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("User profile"),
          backgroundColor: Colors.pinkAccent,
          toolbarHeight: 140,
          actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.account_circle,
                  color: Colors.pink[100],
                ))
          ],
        ),
      body: Container(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              child: Column(
                children: [

                  SizedBox(height: 80),
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Username or Email",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide.none),
                      fillColor:Theme.of(context).primaryColor.withOpacity(0.1),filled:true,prefixIcon: Icon(Icons.person)),
                  ),

                  SizedBox(height: 30),
                  TextField(
                    decoration: InputDecoration(
                      hintText: "email",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide.none),
                      fillColor:Theme.of(context).primaryColor.withOpacity(0.1),filled:true,prefixIcon: Icon(Icons.mail_lock)),
                  ),

                  SizedBox(height: 30),
                  TextField(
                    decoration: InputDecoration(
                      hintText: "password",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide.none),
                      fillColor:Theme.of(context).primaryColor.withOpacity(0.1),filled:true,prefixIcon: Icon(Icons.lock)),
                  ),
                ],
              ),
            ),
          ),
        ),

      
    );
  }
}
