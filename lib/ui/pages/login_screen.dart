import 'package:flutter/material.dart';
import 'package:jadhub_flutter/ui/pages/home_page.dart';
import 'package:jadhub_flutter/utils/color.dart';
import 'package:jadhub_flutter/widget/button_widget.dart';
import 'package:intl/intl.dart';
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: EdgeInsets.only(bottom: 30),
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.4,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [orangeColors, orangeLightColors],
                    end: Alignment.bottomCenter,
                    begin: Alignment.topCenter),
                borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(100))),
            child: Stack(
              children: <Widget>[
                Positioned(
                    bottom: 20,
                    right: 20,
                    child: Text(
                      'Login ke JadHub',
                      style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: 'Poppins'),
                    )),
                Container(
                  margin: EdgeInsets.only(top:50),
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
                      SizedBox(height: 10,),
                      Text('Selamat Datang', style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),)
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
                margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    _textInput(hint: 'Username', icon: Icons.account_circle),
                    _textInput(hint: 'Password', icon: Icons.vpn_key),
                    Expanded(
                      child: Center(
                        child: ButtonWidget(
                          onClick: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePage(
                                       DateTime.now()
                                    ),
                                  ),
                            );
                          },
                          btnText: "LOGIN",
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        ],
      ),
    ));
  }

   Widget _textInput({controller, hint, icon}) {
     bool ya = false;
     if (hint == 'Password') {
       ya = true;
     }
    return Container(
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Colors.white,
      ),
      padding: EdgeInsets.only(left: 10),
      child: TextFormField(
        obscureText: ya,
        controller: controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          prefixIcon: Icon(icon),

        ),
      ),
    );
  }
}
