import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:micros_user_app/data/blocs/blocs.dart';
import 'package:micros_user_app/data/models/models.dart';
import 'package:micros_user_app/data/services/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:micros_user_app/env.dart';

class ClientTravelMapController {


  late BuildContext context;
  late GlobalKey<ScaffoldState> key =  GlobalKey();
  late Function refresh;

  // final Completer<GoogleMapController> _mapController = Completer();

  CameraPosition initialPosition = const CameraPosition(
      target: LatLng(1.2342774, -77.2645446),
      zoom: 14.0
  );

  // late Position _position;
  // late StreamSubscription<Position> _positionStream;
  late BitmapDescriptor markerDriver;
  late BitmapDescriptor fromMarker;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  late BitmapDescriptor toMarker;
  late Set<Polyline> polylines;
  late List<LatLng> points;
  late LocationBloc locationBloc;
  late MapBloc mapBloc;
  late TravelInfo? travelInfo;
  late LatLng _driverLatLng;
  late Driver? driver;
  late Timer timer;
  late bool isRouteReady;
  late bool isStartTravel;
  late bool isPickupTravel;
  String currentStatus = '';
  Color colorStatus = Colors.white;
  // GeofireProvider _geofireProvider;
  // AuthProvider _authProvider;
  // DriverProvider _driverProvider;
  // PushNotificationsProvider _pushNotificationsProvider;

  // bool isConnect = false;
  // ProgressDialog _progressDialog;

  // StreamSubscription<DocumentSnapshot> _statusSuscription;
  // StreamSubscription<DocumentSnapshot> _driverInfoSuscription;

  // late String _idTravel;

  ClientTravelMapController(){
    polylines = {};
    points = [];
    isRouteReady = false;
    isStartTravel = false;
    isPickupTravel = false;
    // _idTravel ='';
  }

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    locationBloc = BlocProvider.of<LocationBloc>(context);
    mapBloc = BlocProvider.of<MapBloc>(context);
    try {
      // _idTravel = ModalRoute.of(context)?.settings.arguments as String;
      getTravelInfo();
      markerDriver = await createMarkerImageFromAsset('assets/img/icon_taxi.png');
      fromMarker = await createMarkerImageFromAsset('assets/img/map_pin_red.png');
      toMarker = await createMarkerImageFromAsset('assets/img/map_pin_blue.png'); 
    } catch (error) {
      debugPrint('ERROR try <ClientTravelMapController> INIT $error');
    }
    // _geofireProvider = new GeofireProvider();
    // _authProvider = new AuthProvider();
    // _driverProvider = new DriverProvider();
    // _pushNotificationsProvider = new PushNotificationsProvider();
    // _progressDialog = MyProgressDialog.createProgressDialog(context, 'Conectandose...');
    // markerDriver = await createMarkerImageFromAsset('assets/img/taxi_icon.png');
    // checkGPS();
    // getDriverInfo();
  }
  //actuliza el driver seleccionado con el timer cada 6 segundos
  //getDriverLocation
  void getDriverInfo(String idDriver) async{
    debugPrint('getDriverInfo--------------');
    try {
      timer = Timer.periodic(const Duration(seconds: 6), (timer) async {
        driver = await DriverService.getbyId(idDriver);
        if (driver != null) {
          _driverLatLng = LatLng(driver!.currentLat, driver!.currentLong);
          addSimpleMarker(
              'driver', 
              _driverLatLng.latitude,
              _driverLatLng.longitude,
              'tu conductor',
              '',
              markerDriver,
          );
          debugPrint('CLIENTE-TRAVEL ->$driver');
          if (!isRouteReady) {
            isRouteReady = true;
            // checkTravelStatus();
          }
          checkTravelStatus();
        }        
        refresh();
      });      
    } catch (error) {
      debugPrint('ERROR TRY <ClientTravelMapController> getDriverInfo:  $error');
    }
  }

  
  
  void checkTravelStatus() async {          
      travelInfo = await TravelInfoService.getbyId(PushNotificationService.token!);
      try {
        if (travelInfo!.status == 'accepted') {
          currentStatus = 'Viaje aceptado';
          colorStatus = Colors.green;
          pickupTravel();
        }
        else if (travelInfo!.status == 'started') {
          currentStatus = 'Viaje iniciado';
          colorStatus = Colors.amber;
          startTravel();
        }
        else if (travelInfo!.status == 'finished') {
          currentStatus = 'Viaje finalizado';
          colorStatus = Colors.red;
        }
        refresh();        
      } catch (error) {
        debugPrint('ERROR TRY CACH: $error');
      }
    
  }

  void pickupTravel() {
    if (!isPickupTravel) {
      isPickupTravel = true;
      LatLng from =  LatLng(_driverLatLng.latitude, _driverLatLng.longitude);
      LatLng to =  LatLng(travelInfo!.fromLat, travelInfo!.fromLng);
      addSimpleMarker('from', to.latitude, to.longitude, 'Recoger aqui', '', fromMarker);
      setPolylines(from, to);
    }
  }

  void getTravelInfo() async{
    try {
      travelInfo = await TravelInfoService.getbyId(PushNotificationService.token!);
      if (travelInfo != null) {      
        getDriverInfo(travelInfo!.idDriver);
        refresh();
      }
      
    } catch (e) {
      
    }
    // Stream<DocumentSnapshot> driverStream = _driverProvider.getByIdStream(_authProvider.getUser().uid);
    // _driverInfoSuscription = driverStream.listen((DocumentSnapshot document) {
    //   driver = Driver.fromJson(document.data());
    // });
  }

  void startTravel() {
    try {
      
    if (!isStartTravel) {
      isStartTravel = true;
      polylines = {};
      points = [];
      markers.remove(markers['from']);
      addSimpleMarker(
          'to',
          travelInfo!.toLat,
          travelInfo!.toLng,
          'Destino',
          '',
          toMarker
      );
      LatLng from =  LatLng(_driverLatLng.latitude, _driverLatLng.longitude);
      LatLng to =  LatLng(travelInfo!.toLat, travelInfo!.toLng);
      setPolylines(from, to);
      refresh();
    }
    } catch (e) {
      
    }
  }
  
  Future<void> setPolylines(LatLng from, LatLng to ) async {
    PointLatLng pointFromLatLng = PointLatLng(from.latitude, from.longitude);
    PointLatLng pointToLatLng = PointLatLng(to.latitude, to.longitude);

    PolylineResult result = await PolylinePoints().getRouteBetweenCoordinates(
        googleApiKey,
        pointFromLatLng,
        pointToLatLng
    );

    for (PointLatLng point in result.points) {
      points.add(LatLng(point.latitude, point.longitude));
    }

    Polyline polyline = Polyline(
      polylineId: const PolylineId('poly'),
      color: Colors.amber,
      points: points,
      width: 6
    );
    polylines.add(polyline);
    // mapBloc.add(onUpdatePolylinesEvent({"ruta":polyline}));
    addSimpleMarker('from',to.latitude, to.longitude, 'Recoger aqui', '', fromMarker);
    // addMarker('to', mapBloc.state.toLatLng!.latitude, mapBloc.state.toLatLng!.longitude, 'Destino', '', toMarker);
  }
  
  void dispose() {
    // _positionStream?.cancel();
    // _statusSuscription?.cancel();
    // _driverInfoSuscription?.cancel();
    timer.cancel();
  }

  void onMapCreated(GoogleMapController controller) {
    controller.setMapStyle('[{"elementType":"geometry","stylers":[{"color":"#212121"}]},{"elementType":"labels.icon","stylers":[{"visibility":"off"}]},{"elementType":"labels.text.fill","stylers":[{"color":"#757575"}]},{"elementType":"labels.text.stroke","stylers":[{"color":"#212121"}]},{"featureType":"administrative","elementType":"geometry","stylers":[{"color":"#757575"}]},{"featureType":"administrative.country","elementType":"labels.text.fill","stylers":[{"color":"#9e9e9e"}]},{"featureType":"administrative.land_parcel","stylers":[{"visibility":"off"}]},{"featureType":"administrative.locality","elementType":"labels.text.fill","stylers":[{"color":"#bdbdbd"}]},{"featureType":"poi","elementType":"labels.text.fill","stylers":[{"color":"#757575"}]},{"featureType":"poi.park","elementType":"geometry","stylers":[{"color":"#181818"}]},{"featureType":"poi.park","elementType":"labels.text.fill","stylers":[{"color":"#616161"}]},{"featureType":"poi.park","elementType":"labels.text.stroke","stylers":[{"color":"#1b1b1b"}]},{"featureType":"road","elementType":"geometry.fill","stylers":[{"color":"#2c2c2c"}]},{"featureType":"road","elementType":"labels.text.fill","stylers":[{"color":"#8a8a8a"}]},{"featureType":"road.arterial","elementType":"geometry","stylers":[{"color":"#373737"}]},{"featureType":"road.highway","elementType":"geometry","stylers":[{"color":"#3c3c3c"}]},{"featureType":"road.highway.controlled_access","elementType":"geometry","stylers":[{"color":"#4e4e4e"}]},{"featureType":"road.local","elementType":"labels.text.fill","stylers":[{"color":"#616161"}]},{"featureType":"transit","elementType":"labels.text.fill","stylers":[{"color":"#757575"}]},{"featureType":"water","elementType":"geometry","stylers":[{"color":"#000000"}]},{"featureType":"water","elementType":"labels.text.fill","stylers":[{"color":"#3d3d3d"}]}]');
    // _mapController.complete(controller);
  }


  Future<BitmapDescriptor> createMarkerImageFromAsset(String path) async {
    ImageConfiguration configuration = const ImageConfiguration();
    BitmapDescriptor bitmapDescriptor =
    await BitmapDescriptor.fromAssetImage(configuration, path);
    return bitmapDescriptor;
  }

  void addMarker(
      String markerId,
      double lat,
      double lng,
      String title,
      String content,
      BitmapDescriptor iconMarker
      ) {

    MarkerId id = MarkerId(markerId);
    Marker marker = Marker(
        markerId: id,
        icon: iconMarker,
        position: LatLng(lat, lng),
        infoWindow: InfoWindow(title: title, snippet: content),
        // draggable: false,
        // zIndex: 2,
        // flat: true,
        // anchor: const Offset(0.5, 0.5),
        // rotation: _position.heading
    );
    markers[id] = marker;
  }


  void addSimpleMarker(
      String markerId,
      double lat,
      double lng,
      String title,
      String content,
      BitmapDescriptor iconMarker
      ) {

    MarkerId id = MarkerId(markerId);
    Marker marker = Marker(
        markerId: id,
        icon: iconMarker,
        position: LatLng(lat, lng),
        infoWindow: InfoWindow(title: title, snippet: content),
    );
    markers[id] = marker;
  }

}