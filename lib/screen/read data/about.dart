import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class about extends StatefulWidget {
  const about({super.key});

  @override
  State<about> createState() => _aboutState();
}

class _aboutState extends State<about> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
                  'About Us',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
        centerTitle: true,
        backgroundColor: Colors.pinkAccent,
        toolbarHeight: 80,
      ),

      body: Column(
        children: [
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
               CircleAvatar(
              radius: 55,
              backgroundImage: AssetImage(
                  "assets/images/big.jpg"),
            ),
                SizedBox(height: 10),
                Text(
                  '6388051 Chavalit Savittrakul',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Front end & back end developer',
                  style: TextStyle(fontSize: 12),
                ),SizedBox(height: 10),
                Center(
                  child: Text(
                  'He is a student at Mahidol University Faculty of Information Communication and Technology. He is interested in code, AI, and games.',
                  textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),


          Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                CircleAvatar(
              radius: 55,
              backgroundImage: AssetImage(
                  "assets/images/mark.jpg"),
            ),
                SizedBox(height: 10),
                Text(
                  '6388155 Watsapol Samittivate',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Front end & back end developer',
                  style: TextStyle(fontSize: 12),
                ),
                Center(
                  child: Text(
                  'He is a student at Mahidol University Faculty of Information Communication and Technology. He is interested in programming, finance, and music.',
                  textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),


          Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                CircleAvatar(
              radius: 55,
              backgroundImage: AssetImage(
                  "assets/images/eff.jpg"),
            ),
                SizedBox(height: 10),
                Text(
                  '6388156 Thitirat Sukijprasert',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  'UX-UI Designer',
                  style: TextStyle(fontSize: 12),
                ),
                Center(
                  child: Text(
                  'She is a student at Mahidol University Faculty of Information Communication and Technology. She is interested in graphic design, UX/UI, and language.',
                  textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}