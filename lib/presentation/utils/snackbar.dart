import 'package:flutter/material.dart';
import 'package:micros_user_app/presentation//utils/colors.dart' as utils;

class Snackbar {

  // static void showSnackbar(BuildContext context, GlobalKey<ScaffoldMessengerState> key, String text) {
  static void showSnackbar(BuildContext context, String text) {
    
    final snackBar = SnackBar(
      content: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14
        ),
      ),
      backgroundColor: utils.Colores.uberCloneColor,
      duration: const Duration(seconds: 3)
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    
    // if (key.currentState == null) return;
    // FocusScope.of(context).requestFocus( FocusNode());
    // key.currentState?.removeCurrentSnackBar();
    // key.currentState?.showSnackBar(snackBar);

  }

}