import 'package:flutter/material.dart';

class ClientTravelMapController {

  late BuildContext context;
  GlobalKey<ScaffoldState> key = GlobalKey();
  late Function refresh;


  void init(BuildContext context, Function refresh) {
    this.context = context;
    this.refresh = refresh;
  }

}