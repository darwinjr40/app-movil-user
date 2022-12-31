import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:lottie/lottie.dart';
import 'package:micros_user_app/presentation/screens/screens.dart';
import 'package:micros_user_app/presentation/utils/colors.dart' as utils;
import 'package:micros_user_app/presentation/widgets/widgets.dart';

class ClientTravelRequestPage extends StatefulWidget {
  const ClientTravelRequestPage({Key? key}) : super(key: key);

  @override
  _ClientTravelRequestPageState createState() => _ClientTravelRequestPageState();
}

class _ClientTravelRequestPageState extends State<ClientTravelRequestPage> {

  final ClientTravelRequestController _con = ClientTravelRequestController();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _con.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _driverInfo(),
          _lottieAnimation(),
          _textLookingFor(),
          _textCounter(),
        ],
      ),
      bottomNavigationBar: _buttonCancel(),
    );
  }

  Widget _buttonCancel() {
    return Container(
      height: 50,
      margin: const EdgeInsets.all(30),
      child: const BtnSolicit(
        text: 'Cancelar viaje',
        color: Colors.amber,
        icon: Icons.cancel_outlined,
        textColor: Colors.black,
      ),
    );
  }

  Widget _textCounter() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 30),
      child: const Text(
        '0',
        style: TextStyle(fontSize: 30),
      ),
    );
  }

  Widget _lottieAnimation() {
    return Lottie.asset(
      'assets/json/car-control.json',
      width: MediaQuery.of(context).size.width * 0.70,
      height: MediaQuery.of(context).size.height * 0.35,
      fit: BoxFit.fill
    );
  }

  Widget _textLookingFor() {
    return const Text(
      'Buscando conductor....',
      style: TextStyle(
        fontSize: 16
      ),
    );
  }

  Widget _driverInfo() {
    return ClipPath(
      clipper: WaveClipperOne(),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.3,
        color: utils.Colores.uberCloneColor,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/img/profile.jpg'),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: const Text(
                'Tu Conductor',
                maxLines: 1,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white
                ),
              ),
            )
          ],
        ),
      ),
    );
  }


  void refresh() {
    setState(() {});
  }
}
