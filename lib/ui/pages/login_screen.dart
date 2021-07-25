import 'package:flutter/material.dart';
import 'package:jadhub_flutter/ui/pages/home_page.dart';
import 'package:jadhub_flutter/utils/color.dart';
import 'package:jadhub_flutter/widget/button_widget.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_session/flutter_session.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController user = TextEditingController();
  TextEditingController pass = TextEditingController();

  Future login() async {
    var url = 'https://jadhub.000webhostapp.com/login.php';
    var response = await http.post(url, body: {
      'username': user.text,
      'password': pass.text,
    });
    var data = json.decode(response.body);

    if (data == 'Succes') {
      await FlutterSession().set("token", user.text);
      Fluttertoast.showToast(
          msg: "Login JadHub berhasil",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );
    } else {
      Fluttertoast.showToast(
        msg: "Username atau Password salah",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: EdgeInsets.only(bottom: 30),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: BoxDecoration(
                color: orangeColors,
                  // gradient: LinearGradient(
                  //     colors: [orangeColors, orangeLightColors],
                  //     end: Alignment.bottomCenter,
                  //     begin: Alignment.topCenter),
                  borderRadius:
                      BorderRadius.only(bottomLeft: Radius.circular(100))),
              child: Stack(
                children: <Widget>[
                  // Positioned(
                  //     bottom: 20,
                  //     right: 20,
                  //     child: Text(
                  //       'Login ke JadHub',
                  //       style: TextStyle(
                  //           color: Colors.white,
                  //           fontSize: 20,
                  //           fontFamily: 'Poppins'),
                  //     )),
                  Container(
                    margin: EdgeInsets.only(top: 50),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('assets/logo.png'),
                            SizedBox(width: 10),
                            Image.asset('assets/lampung.png'),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Selamat Datang',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Masukan username dan\n password untuk masuk ke\nJadhub',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Card(
              margin: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              elevation: 8,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Container(
                  margin:
                      EdgeInsets.only(left: 20, right: 20, top: 20, bottom: MediaQuery.of(context).size.height * 0.1),
                    padding: EdgeInsets.symmetric(horizontal: 13),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        ' Username',
                        style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w600,
                            color: orangeColors),
                      ),
                      _textInput(
                          hint: 'Username',
                          icon: Icons.account_circle,
                          controller: user),
                          SizedBox(height:10),
                      Text(
                        ' Password',
                        style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w600,
                            color: orangeColors),
                      ),
                      _textInput(
                          hint: 'Password',
                          icon: Icons.vpn_key,
                          controller: pass),
                      SizedBox(
                        height: 25,
                      ),
                      Center(
                        child: ButtonWidget(
                          onClick: () {
                            login();
                          },
                          btnText: "MASUK",
                        ),
                      ),
                    ],
                  )),
            ),
          ],
        ),
      ),
    ));
  }

  bool _showPassword = false;
  void _togglevisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  Widget _textInput({controller, hint, icon}) {
    bool ya = false;
    if (hint == 'Password') {
      ya = true;
    }
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: Container(
        margin: EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Colors.white,
        ),
        padding: EdgeInsets.only(left: 10),
        child: TextFormField(
          obscureText: ya ? !_showPassword : false,
          controller: controller,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hint,
            prefixIcon: Icon(icon),
            suffixIcon: ya
                ? GestureDetector(
                    onTap: () {
                      _togglevisibility();
                    },
                    child: Icon(
                      _showPassword ? Icons.visibility : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                  )
                : null,
          ),
        ),
      ),
    );
  }
}
