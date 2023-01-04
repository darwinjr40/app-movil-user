import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:micros_user_app/data/blocs/blocs.dart';
import 'package:micros_user_app/presentation/screens/travel_map/client_travel_map_controller.dart';
import 'package:flutter/scheduler.dart';
import 'package:micros_user_app/presentation/views/views.dart';
import 'package:micros_user_app/presentation/widgets/widgets.dart';


class ClientTravelMapPage extends StatefulWidget {
  const ClientTravelMapPage({Key? key}) : super(key: key);

  @override
  ClientTravelMapPageState createState() => ClientTravelMapPageState();
}

class ClientTravelMapPageState extends State<ClientTravelMapPage> {

  final ClientTravelMapController _con =  ClientTravelMapController();

  late LocationBloc locationBloc;
  late MapBloc mapBloc;
  
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh);
    });
    locationBloc = BlocProvider.of<LocationBloc>(context);
    mapBloc = BlocProvider.of<MapBloc>(context);
    // authService = Provider.of<AuthService>(context, listen: false);
    // locationBloc.getCurrentPosition();
    locationBloc.startFollowingUser();
    // mapBloc.loadDriver(authService.user.id, authService.vehiculo.id);      
  }

  @override
  void dispose() {
    locationBloc.stopFollowingUser();
    super.dispose();
    _con.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // const statusView = StatusView();
    return Scaffold(
      key: _con.key,
      body: BlocBuilder<LocationBloc, LocationState>(
        builder: (context, locationState) {
          if (locationState.lastKnownLocation == null) {
            return const Center(
              child: Text('Espere por favor...'),
            );
          }
          return BlocBuilder<MapBloc, MapState>(
            builder: (context, mapState) {
              return SingleChildScrollView(
                child: Stack(
                  children: [
                    MapView(
                      initialLocation: locationState.lastKnownLocation!,
                      polylines: _con.polylines,
                      circles: const {},
                      markers: Set<Marker>.of(_con.markers.values),
                    ),
                    // const Positioned(
                    //   bottom: 24,
                    //   left: 10,
                    //   child: statusView,
                    // ),
                    SafeArea(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _buttonUserInfo(),
                                _cardStatusInfo(_con.currentStatus),

                              // Column(
                              //   children: [
                                  // _cardKmInfo('0'),
                                  // _cardMinInfo('0')
                              //   ],
                              // ),
                            ],
                          ),
                          // Expanded(child: Container()),
                           
                          //  _buttonStatus(),
                          
                        ],
                      ),
                    ),
                    // Positioned(
                    //   bottom: 5,
                    //   left: 5,
                    //   child: _buttonStatus(),
                    // ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: const [
              BtnFollowUser(),              
              // BtnToogleUserRoute(),
              BtnCurrentLocation(),
            ],
          ),
        ],
      ),
    );
  }



  Widget _cardStatusInfo(String status) {
    return SafeArea(
        child: Container(
          width: 110,
          padding: EdgeInsets.symmetric(vertical: 10),
          margin: EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
              color: _con.colorStatus,
              borderRadius: BorderRadius.all(Radius.circular(20))
          ),
          child: Text(
            status,
            maxLines: 1,
            textAlign: TextAlign.center,
          ),
        )
    );
  }
    Widget _buttonUserInfo() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        alignment: Alignment.centerLeft,
        margin: const EdgeInsets.symmetric(horizontal: 5),
        child: Card(
          shape: const CircleBorder(),
          color: Colors.white,
          elevation: 4.0,
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Icon(
              Icons.person,
              color: Colors.grey[600],
              size: 20,
            ),
          ),
        ),
      ),
    );
  }


  //   Widget _cardKmInfo(String km) {
  //   return SafeArea(
  //       child: Container(
  //         width: 110,
  //         margin: const EdgeInsets.only(top: 10),
  //         // ignore: prefer_const_constructors
  //         decoration: BoxDecoration(
  //           color: Colors.black,
  //           borderRadius: const BorderRadius.all(Radius.circular(20))
  //         ),
  //         child: Text(
  //           '$km km',
  //           maxLines: 1,
  //           textAlign: TextAlign.center,
  //           style: const TextStyle(color: Colors.white),
  //         ),
  //       )
  //   );
  // }


  // Widget _cardMinInfo(String min) {
  //   return SafeArea(
  //       child: Container(
  //         width: 110,
  //         margin: const EdgeInsets.only(top: 10),
  //         decoration: const BoxDecoration(
  //           color: Colors.black,
  //           borderRadius: BorderRadius.all(Radius.circular(20))
  //         ),
  //         child: Text(
  //           '$min seg',
  //           maxLines: 1,
  //           textAlign: TextAlign.center,
  //            style: const TextStyle(color: Colors.white),
  //         ),
  //       )
  //   );
  // }


  void refresh() {
    setState(() {});
  }
}
