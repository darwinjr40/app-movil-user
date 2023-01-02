// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
// import 'package:uber_clone_flutter_udemy/src/utils/colors.dart' as utils;


class BtnSolicit extends StatelessWidget {

  final Color color;
  final Color textColor;
  final String text;
  final IconData icon;
  final Function? onPressed;

  const BtnSolicit({
    Key? key, 
    this.color = Colors.black,
    this.textColor = Colors.white,
    this.icon = Icons.arrow_forward_ios,
    this.onPressed,
    required this.text
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onPressed!();
      },
      // color: color,
      // textColor: textColor,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              height: 50,
              alignment: Alignment.center,
              child: Text(
                  text,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold
                ),
              )
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: SizedBox(
              height: 50,
              child: CircleAvatar(
                radius: 15,
                child: Icon(
                  icon,
                  color: const Color(0xFF222327),
                ),
                backgroundColor: Colors.black,
              ),
            ),
          )
        ],
      ),
      // shape: RoundedRectangleBorder(
      //   borderRadius: BorderRadius.circular(15)
      // ),
    );
  }
}
