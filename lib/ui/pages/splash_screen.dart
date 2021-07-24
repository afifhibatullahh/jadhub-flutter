import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jadhub_flutter/utils/color.dart';
import 'package:jadhub_flutter/ui/pages/login_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 4000), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [orangeColors, orangeLightColors],
              end: Alignment.bottomCenter,
              begin: Alignment.topCenter),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Image.asset("assets/logo.png"),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Text('Dinas Perhubungan Provinsi Lampung', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
