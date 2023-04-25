import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prototype/screen/read%20data/get_cafe_detail.dart';

class GetCafeList extends StatelessWidget {
  late final String documentID;
  GetCafeList({required this.documentID});

  @override
  Widget build(BuildContext context) {
    CollectionReference cafes =
        FirebaseFirestore.instance.collection('cafeLists');
    return FutureBuilder<DocumentSnapshot>(
      future: cafes.doc(documentID).get(),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          String imageUrl = data['img'];
          return InkWell(
            
              onTap: () {
                print("User tapped on cafe with ID: $documentID");
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => GetCafeDetail(documentID: documentID),
                ));
              },
            child: Container(
              padding: EdgeInsets.all(16),
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.pink.shade100,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Colors.grey[300]!,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(imageUrl),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Text("Cafe Name:", style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(width: 4),
                      Text("${data['cafe_name']}"),
                    ],
                  ),
                  // SizedBox(height: 8),
                  // Row(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     Text("Description:", style: TextStyle(fontWeight: FontWeight.bold)),
                  //     SizedBox(width: 4),
                  //     Expanded(
                  //       child: Text("${data['description']}"),
                  //     ),
                  //   ],
                  // ),
                  // SizedBox(height: 8),
                ],
              ),
            ),
            hoverColor: Colors.grey[200],
          );
        }
        return Text("Loading..");
      }),
    );
  }
}
