import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:jadhub_flutter/res/routes.dart';
import 'package:jadhub_flutter/ui/pages/contribution_pages.dart';
import 'package:jadhub_flutter/utils/color.dart';

class MainDrawer extends StatelessWidget {
  static const int $copy = 0x00A9;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(children: <Widget>[
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(20),
          color: orangeColors,
          child: Center(
            child: Column(children: [
              Container(
                width: 100,
                height: 100,
                margin: EdgeInsets.only(top: 30),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(
                          'https://1.bp.blogspot.com/-x0XnjY4pIlY/W6XY0lAU3xI/AAAAAAAAD3o/JmngsUDBWVc2n_oijzaCpC8Vq1OPeLU9QCEwYBhgL/s1600/dishub%2Bpng.png'),
                    )),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: Text(
                  'Dinas Perhubungan Pronvinsi Lampung',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w400),
                  textAlign: TextAlign.center,
                ),
              ),
            ]),
          ),
        ),
        ListTile(
            leading: Icon(Icons.info),
            title: Text('Tentang Aplikasi'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ContributionPages(),
                ),
              );
            }),
        ListTile(
          leading: Icon(Icons.exit_to_app),
          title: Text('Keluar'),
          onTap: () => showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text('Yakin?'),
              content: const Text('Yakin ingin keluar dari aplikasi?'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Batal'),
                  child: const Text('Batal'),
                ),
                TextButton(
                  onPressed: () => {
                    FlutterSession().set('token', ''),
                    Navigator.pop(context),
                    Navigator.pop(context),
                    Navigator.popAndPushNamed(context, AppRoutes.login)
                  },
                  child: const Text('OK'),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Container(
            alignment: Alignment.bottomCenter,
            child: Text(
              'Copyright © 2021 Mahasiswa KP Insitut Teknologi Sumatera',
              style: TextStyle(fontSize: 9, fontWeight: FontWeight.w600, height: 13),
            ),
          ),
        ),
      ]),
    );
  }
}
