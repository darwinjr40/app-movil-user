import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:micros_user_app/data/blocs/blocs.dart';

class BtnshowBusIntersection extends StatelessWidget {
  const BtnshowBusIntersection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final searchBloc = BlocProvider.of<SearchBloc>(context);
    // final driverBloc = BlocProvider.of<DriverBloc>(context);
    // return BlocBuilder<MapBloc, MapState>(builder: (context, mapState) {
      return BlocBuilder<DriverBloc, DriverState>(
          builder: (context, driverState) {
        return FadeInRight(
            duration: const Duration(milliseconds: 300),
            child: const _BtnIntersectionBody());
      });
    // });
  }
}

class _BtnIntersectionBody extends StatelessWidget {
  const _BtnIntersectionBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: CircleAvatar(
        backgroundColor: Colors.green[300],
        maxRadius: 25,
        child: IconButton(
          icon: const Icon(
            Icons.bus_alert,
            color: Colors.black,
            // color: Color.fromARGB(255, 99, 80, 80),
          ),
          onPressed: () async {
            // ! Instancias de los gestores de estado

            final locationBloc = BlocProvider.of<LocationBloc>(context);
            double lat = locationBloc.state.lastKnownLocation!.latitude;
            double lon = locationBloc.state.lastKnownLocation!.longitude;

            final driverBloc = BlocProvider.of<DriverBloc>(context);
            driverBloc
                .add(OnGetDriverEvent(busId: 1, latitud: lat, longitud: lon));

            final mapBloc = BlocProvider.of<MapBloc>(context);
            // await mapBloc.drawRouteMarker(driverBloc.state.polylinesDrivers);
            mapBloc.add(OnDrawRouteMarkerEvent(
                polylines: driverBloc.state.polylinesDrivers));
          },
        ),
      ),
    );
  }
}