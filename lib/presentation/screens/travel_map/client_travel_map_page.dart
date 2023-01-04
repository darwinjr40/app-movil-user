import 'package:flutter/material.dart';
import 'package:micros_user_app/presentation/screens/travel_map/client_travel_map_controller.dart';
import 'package:flutter/scheduler.dart';


class ClientTravelMapPage extends StatefulWidget {
  const ClientTravelMapPage({Key? key}) : super(key: key);

  @override
  ClientTravelMapPageState createState() => ClientTravelMapPageState();
}

class ClientTravelMapPageState extends State<ClientTravelMapPage> {

  final ClientTravelMapController _con =  ClientTravelMapController();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('PANTALLA DEL MAPA DEL CLIENTE'),),
    );
  }

  void refresh() {
    setState(() {});
  }
}
