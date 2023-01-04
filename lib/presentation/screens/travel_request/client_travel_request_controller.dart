import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:micros_user_app/data/blocs/blocs.dart';
import 'package:micros_user_app/data/models/models.dart';
import 'package:micros_user_app/data/services/services.dart';
import 'package:micros_user_app/presentation/utils/utils.dart';

class ClientTravelRequestController {

  late BuildContext context;
  late Function refresh;
  late GlobalKey<ScaffoldState> key;
  late MapBloc mapBloc;
  late DriverBloc driverBloc;
  
  late TravelInfoService _travelInfoService;
  // late DriverService _driverService;
  // late StreamSubscription<List<Driver>> _streamSubscription;

  late StreamSubscription<TravelInfo> _streamStatusSubscription;

  List<String> nearbyDrivers = [];

  ClientTravelRequestController(){
    key = GlobalKey<ScaffoldState>();
    _travelInfoService = TravelInfoService();
    // _driverService = DriverService();
  }

  void init(BuildContext context, Function refresh) {
    this.context = context;
    this.refresh = refresh;
    mapBloc = BlocProvider.of<MapBloc>(context);
    driverBloc = BlocProvider.of<DriverBloc>(context);
    _createTravelInfo();
    _getNearbyDrivers();
  }

  void _checkDriverResponse() async {
    Stream<TravelInfo> stream =  _travelInfoService.getByIdStream(PushNotificationService.token!);
    _streamStatusSubscription = stream.listen((TravelInfo travelInfo) {      
      if (travelInfo.idDriver != '-' && travelInfo.status == 'accepted') {
        _travelInfoService.timer.cancel();
        // Navigator.pushNamedAndRemoveUntil(context, 'client/travel/map', (route) => false);
        // Navigator.pushNamed(context, 'client/travel/map');
        Navigator.pushReplacementNamed(context, 'client/travel/map');
      } else if (travelInfo.status == 'no_accepted'){
        _travelInfoService.timer.cancel();
        Snackbar.showSnackbar(context, "El conductor no acepto tu solicitud");
        Future.delayed(const Duration(milliseconds: 4000), (){
            Navigator.pushNamedAndRemoveUntil(context, 'loading', (route) => false);
        });
      }
    });
  }

  void dispose () {
    // _streamSubscription.cancel();
    _streamStatusSubscription.cancel();
    _travelInfoService.timer.cancel();
  }

  void _getNearbyDrivers() {
    // Stream<List<DocumentSnapshot>> stream = _geofireProvider.getNearbyDrivers(
    //     fromLatLng.latitude,
    //     fromLatLng.longitude,
    //     5
    // );

    // _streamSubscription = stream.listen((List<DocumentSnapshot> documentList) {
    //   for (DocumentSnapshot d in documentList) {
    //     print('CONDUCTOR ENCONTRADO ${d.id}');
    //     nearbyDrivers.add(d.id);
    //   }
    // });
    final drivers = driverBloc.state.listaDrivers;
    debugPrint('${drivers[0].token}--------------------------');

    final driversString = drivers.map((Driver e) => e.id.toString());
    nearbyDrivers = List<String>.of(driversString);
    debugPrint('${nearbyDrivers.length}--------------------------');
    if (drivers.isNotEmpty) {
      getDriverInfo(drivers[0]);
      // getDriverInfo(nearbyDrivers[0]);
      // _streamSubscription.cancel();
    }
  }
  void _createTravelInfo() async {
    TravelInfo travelInfo =  TravelInfo(
      idCode: PushNotificationService.token ?? "1",
      from: mapBloc.state.from!,
      to: mapBloc.state.to!,
      fromLat: mapBloc.state.fromLatLng!.latitude,
      fromLng: mapBloc.state.fromLatLng!.longitude,
      toLat: mapBloc.state.toLatLng!.latitude,
      toLng: mapBloc.state.toLatLng!.longitude,
      status: 'created'
    );
    await _travelInfoService.createOrUpdate(travelInfo);
    _checkDriverResponse();

  }

  Future<void> getDriverInfo(Driver driver) async {
    // Driver driver = await _driverProvider.getById(idDriver);
    if (driver.token != null) {
      // _sendNotification('dlUKq-YKS6aIlEBxFw3CZj:APA91bFQaEqd2njs25yqTdG0_ZYLeAw69BT_EFlP5uOgUkPpZKs5P56LFrP8Mo3ghDzrS2uAyy9OkvLX8xdwoshCcRtrHYvG366HCmv2SPEYDvBbxZHW3l9XUGL_mftjqu_gnw4tLvxb');      
      _sendNotification(driver.token!);
    }
  }

  void _sendNotification(String token) {
    Map<String, dynamic> data = {
      'click_action': 'FLUTTER_NOTIFICATION_CLICK',
      // 'idClient': _authProvider.getUser().uid,
      'tokenClient': PushNotificationService.token ?? '',
      'origin': mapBloc.state.from!,
      'destination': mapBloc.state.to!,
    };

    debugPrint(data.toString());
    PushNotificationService.sendMessage(token, data, 'Solicitud de servicio', 'Un cliente esta solicitando viaje');
  }
}