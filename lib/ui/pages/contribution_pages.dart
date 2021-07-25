import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jadhub_flutter/utils/color.dart';

class ContributionPages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'JadHub',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              color: Colors.white),
        ),
        iconTheme: IconThemeData(
          color: Colors.black, 
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.groups),
            onPressed: () {
              return null;
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo_itera.png',
              width: MediaQuery.of(context).size.width * 0.4,
            ),
            Text(
              '© 2021 ITERA Intern Team Development',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 5,
            ),
            Text('Jadhub v1.0'),
            SizedBox(height: MediaQuery.of(context).size.height * 0.2),
            Text('Build With 💙'),
            SizedBox(height: 10),
            Text('Thanks to\nAfif Hibatullah',textAlign: TextAlign.center,),
          ],
        ),
      ),
    );
  }
}
