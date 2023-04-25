import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prototype/screen/read%20data/Map.dart';
import 'package:prototype/screen/read%20data/about.dart';
import 'package:prototype/screen/read%20data/get_cafe_list.dart';

import 'package:prototype/screen/UserProfile.dart';

class FindKafeHome extends StatefulWidget {
  const FindKafeHome({Key? key}) : super(key: key);

  @override
  _FindKafeHomeState createState() => _FindKafeHomeState();
}

class _FindKafeHomeState extends State<FindKafeHome> {
  Future<List<String>>? _idsFuture;

  Future<List<String>> getId() async {
    final snapshot =
        await FirebaseFirestore.instance.collection('cafeLists').get();
    return snapshot.docs.map((document) => document.reference.id).toList();
  }

  @override
  void initState() {
    super.initState();
    _idsFuture = getId();
  }

  bool isDefault = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FindKafe"),
        backgroundColor: Colors.pinkAccent,
        toolbarHeight: 80,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return about();
                }));
              },
              icon: Icon(
                Icons.info_outlined,
                color: Colors.pink[100],
              )),
          IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return MapScreen();
                }));
              },
              icon: Icon(
                Icons.place_rounded,
                color: Colors.pink[100],
              )),
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserProfile()),
                );
              },
              child: IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return UserProfile();
                    }));
                  },
                  icon: Icon(
                    Icons.person,
                    color: Colors.pink[100],
                  )),
            ),
          ),
        ],
      ),
      body: Center(
        child: FutureBuilder(
          future: _idsFuture,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final ids = snapshot.data as List<String>;
              return Expanded(
                child: ListView.builder(
                  itemCount: ids.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: GetCafeList(documentID: ids[index]),
                    );
                  },
                ),
              );
            } else if (snapshot.hasError) {
              return Text('Error retrieving document references');
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
