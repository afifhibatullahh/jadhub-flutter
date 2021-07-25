import 'package:flutter/material.dart';
import 'package:jadhub_flutter/utils/color.dart';

class ButtonWidget extends StatelessWidget {
  var btnText = "";
  var onClick;

  ButtonWidget({this.btnText, this.onClick});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      child: InkWell(
        onTap: onClick,
        child: Container(
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [orangeColors, orangeLightColors],
                end: Alignment.centerLeft,
                begin: Alignment.centerRight),
            borderRadius: BorderRadius.all(
              Radius.circular(100),
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            btnText,
            style: TextStyle(
                fontSize: 27, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
