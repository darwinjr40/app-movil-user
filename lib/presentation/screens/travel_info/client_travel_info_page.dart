import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:micros_user_app/data/blocs/blocs.dart';
import 'package:micros_user_app/presentation/widgets/btn_solicit.dart';
import 'package:micros_user_app/presentation/screens/screens.dart';


class ClientTravelInfoPage extends StatefulWidget {
  const ClientTravelInfoPage({Key? key}) : super(key: key);

  @override
  _ClientTravelInfoPageState createState() => _ClientTravelInfoPageState();
}

class _ClientTravelInfoPageState extends State<ClientTravelInfoPage> {
  final ClientTravelInfoController _con =  ClientTravelInfoController();
  late MapBloc mapBloc = BlocProvider.of<MapBloc>(context);
  
  @override
  void initState() {
    super.initState();    
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) { //iniciar controllador
      _con.init(context, refresh);
    });

    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _con.key,
      body: Stack(
        children: [
          Align(
            child: _googleMapsWidget(),
            alignment: Alignment.topCenter,
          ),
          Align(
            child: _cardTravelInfo(),
            alignment: Alignment.bottomCenter,
          ),
          Align(
            child: _buttonBack(),
            alignment: Alignment.topLeft,
          ),
          Align(
            child: _cardKmInfo(_con.km),
            // child: _cardKmInfo('0 Km'),
            alignment: Alignment.topRight,
          ),
          Align(
            child: _cardMinInfo(_con.min),
            // child: _cardMinInfo('0 Min'),
            alignment: Alignment.topRight,
          )
        ],
      ),
    );
  }

  Widget _cardTravelInfo() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.38,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))
      ),
      child: Column(
        children:  [
           ListTile(
            title: const Text(
              'Desde',
              style: TextStyle(
                fontSize: 15
              ),
            ),
            subtitle: Text(
              mapBloc.state.from ?? '...',
              // 'Cr falsa con calle falsa',
              style: const TextStyle(
                fontSize: 13
              ),
            ),
            leading: const Icon(Icons.location_on),
          ),
           ListTile(
            title: const Text(
              'Hasta',
              style: TextStyle(
                  fontSize: 15
              ),
            ),
            subtitle: Text(
              mapBloc.state.to ?? '...',
              // 'Cr falsa con calle falsa',
              style: const TextStyle(
                  fontSize: 13
              ),
            ),
            leading: const Icon(Icons.my_location),
          ),
          ListTile(
            title: const Text(
              'Precio',
              style: TextStyle(
                  fontSize: 15
              ),
            ),
            subtitle: Text(
              '${_con.minTotal.toStringAsFixed(2)}Bs - ${_con.maxTotal.toStringAsFixed(2)}Bs',              
              // '0.0\$',
              style: const TextStyle(
                  fontSize: 13
              ),
            ),
            leading: const Icon(Icons.attach_money),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 30),
            child: BtnSolicit(
              onPressed: _con.goToRequest,
              text: 'CONFIRMAR',
              textColor: Colors.black,
              color: Colors.amber,
            ),
          )
        ],
      ),
    );
  }

  Widget _cardKmInfo(String km) {
    return SafeArea(
        child: Container(
          width: 110,
          padding: const EdgeInsets.symmetric(horizontal: 30),
          margin: const EdgeInsets.only(right: 10, top: 10),
          decoration: const BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.all(Radius.circular(20))
          ),
          child: Text(km, maxLines: 1),
          // child: Text(km ?? '0 Km'),
        )
    );
  }
  
  Widget _cardMinInfo(String min) {
    return SafeArea(
        child: Container(
          width: 110,
          padding: const EdgeInsets.symmetric(horizontal: 30),
          margin: const EdgeInsets.only(right: 10, top: 35),
          decoration: const BoxDecoration(
            color: Colors.yellow,
            borderRadius: BorderRadius.all(Radius.circular(20))
          ),
          child: Text(min, maxLines: 1),
          // child: Text(min ?? '0 Min'),
        )
    );
  }

  Widget _buttonBack() {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.only(left: 10),
        child: const CircleAvatar(
          radius: 20,
          backgroundColor: Colors.white,
          child: Icon(Icons.arrow_back, color: Colors.black,),
        ),
      ),
    );
  }

  Widget _googleMapsWidget() {
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: _con.initialPosition,
      onMapCreated: _con.onMapCreated,
      myLocationEnabled: false,
      myLocationButtonEnabled: false,
      markers: Set<Marker>.of(_con.markers.values),
      polylines: _con.polylines,
    );
  }

  void refresh() {
    setState(() {});
  }
}
