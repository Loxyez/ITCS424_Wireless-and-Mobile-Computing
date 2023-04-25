import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetCafeDetail extends StatefulWidget {
  const GetCafeDetail({super.key, required this.documentID});
  final String documentID;
  @override
  State<GetCafeDetail> createState() => _GetCafeDetailState();
}

class _GetCafeDetailState extends State<GetCafeDetail> {

  late Future<DocumentSnapshot> _cafeFuture;

  @override
  void initState() {
    super.initState();
    // Fetch the data for the specific cafe from Firestore
    _cafeFuture = FirebaseFirestore.instance.collection('cafeLists').doc(widget.documentID).get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: Text('Find Cafe'),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: _cafeFuture,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!snapshot.hasData) {
            return Center(
              child: Text('No data found.'),
            );
          }
          final data = snapshot.data!.data() as Map<String, dynamic>;
          return Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Display the cafe name
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    data['cafe_name'],
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
                // Display the cafe image
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Image.network(
                    data['img'],
                    fit: BoxFit.cover,
                  ),
                ),
                // Display the cafe description
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    data['description'],
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
