import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:micros_user_app/data/blocs/blocs.dart';
import 'package:micros_user_app/data/models/models.dart';
import 'package:micros_user_app/data/services/services.dart';
import 'package:micros_user_app/env.dart';

class ClientTravelInfoController {
  /* #Atributos */
  late BuildContext context;
  late GoogleService _googleService;
  late PriceService _priceService;

  late Function refresh;
  late GlobalKey<ScaffoldState> key;
  late Completer<GoogleMapController> _mapController;
  late CameraPosition initialPosition;
  late Map<MarkerId, Marker> markers;
  late Set<Polyline> polylines;
  late List<LatLng> points;
  late BitmapDescriptor fromMarker;
  late BitmapDescriptor toMarker;
  late MapBloc mapBloc;
  late Direction _directions;
  late String min;
  late String km;
  late double minTotal; 
  late double maxTotal;
  /* #Constructor */
  ClientTravelInfoController(){
    key =  GlobalKey<ScaffoldState>();
    _mapController = Completer();
    initialPosition = const CameraPosition(
      target: LatLng(1.2342774, -77.2645446),
      zoom: 14.0
    );
    markers = {};
    polylines = {};
    points = [];
    km = '';
    min = '';
    minTotal = 0;
    maxTotal = 0;
  }

  void  init(BuildContext context, Function refresh) async{
    this.context = context;
    this.refresh = refresh;
    _googleService = GoogleService();
    _priceService = PriceService();
    fromMarker = await createMarkerImageFromAsset('assets/img/map_pin_red.png');
    toMarker = await createMarkerImageFromAsset('assets/img/map_pin_blue.png');
    mapBloc = BlocProvider.of<MapBloc>(context);
    animateCameraToPosition(mapBloc.state.fromLatLng!.latitude, mapBloc.state.fromLatLng!.longitude);
    getGoogleMapsDirections(mapBloc.state.fromLatLng!, mapBloc.state.toLatLng!);
  }

  void getGoogleMapsDirections(LatLng from, LatLng to) async {
    _directions = await _googleService.getGoogleMapsDirections(
        from.latitude,
        from.longitude,
        to.latitude,
        to.longitude
    );
    min = _directions.duration.text;
    km = _directions.distance.text;
    print('KM: $km');
    print('MIN: $min');
    calculatePrice();
    refresh();
  }

  void goToRequest() {
    Navigator.pushNamed(context, 'client/travel/request');
  }
  void calculatePrice() async {
    // Price prices = await _priceService.getAll();
    try {
      Price prices = Price(km: 3, min: 1, minValue: 5);
      double kmValue = double.parse(km.split(" ")[0]) * prices.km;
      double minValue = double.parse(min.split(" ")[0]) * prices.min;
      double total = kmValue + minValue;
      minTotal = total - 3;
      maxTotal = total + 3;
      refresh();      
    } catch (error) {
      debugPrint("calculatePrice: $error");
    }
  }
  Future<void> setPolylines() async {
    PointLatLng pointFromLatLng = PointLatLng(mapBloc.state.fromLatLng!.latitude, mapBloc.state.fromLatLng!.longitude);
    PointLatLng pointToLatLng = PointLatLng(mapBloc.state.toLatLng!.latitude, mapBloc.state.toLatLng!.longitude);

    PolylineResult result = await PolylinePoints().getRouteBetweenCoordinates(
        googleApiKey,
        pointFromLatLng,
        pointToLatLng
    );

    print('--------------------------');
    print(result.points);
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
    addMarker('from', mapBloc.state.fromLatLng!.latitude, mapBloc.state.fromLatLng!.longitude, 'Recoger aqui', '', fromMarker);
    addMarker('to', mapBloc.state.toLatLng!.latitude, mapBloc.state.toLatLng!.longitude, 'Destino', '', toMarker);
    refresh();
  }

  Future animateCameraToPosition(double latitude, double longitude) async {
    GoogleMapController controller = await _mapController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
            bearing: 0,
            target: LatLng(latitude, longitude),
            zoom: 15
        )
    ));
  }
  void onMapCreated(GoogleMapController controller) async{
    controller.setMapStyle('[{"elementType":"geometry","stylers":[{"color":"#212121"}]},{"elementType":"labels.icon","stylers":[{"visibility":"off"}]},{"elementType":"labels.text.fill","stylers":[{"color":"#757575"}]},{"elementType":"labels.text.stroke","stylers":[{"color":"#212121"}]},{"featureType":"administrative","elementType":"geometry","stylers":[{"color":"#757575"}]},{"featureType":"administrative.country","elementType":"labels.text.fill","stylers":[{"color":"#9e9e9e"}]},{"featureType":"administrative.land_parcel","stylers":[{"visibility":"off"}]},{"featureType":"administrative.locality","elementType":"labels.text.fill","stylers":[{"color":"#bdbdbd"}]},{"featureType":"poi","elementType":"labels.text.fill","stylers":[{"color":"#757575"}]},{"featureType":"poi.park","elementType":"geometry","stylers":[{"color":"#181818"}]},{"featureType":"poi.park","elementType":"labels.text.fill","stylers":[{"color":"#616161"}]},{"featureType":"poi.park","elementType":"labels.text.stroke","stylers":[{"color":"#1b1b1b"}]},{"featureType":"road","elementType":"geometry.fill","stylers":[{"color":"#2c2c2c"}]},{"featureType":"road","elementType":"labels.text.fill","stylers":[{"color":"#8a8a8a"}]},{"featureType":"road.arterial","elementType":"geometry","stylers":[{"color":"#373737"}]},{"featureType":"road.highway","elementType":"geometry","stylers":[{"color":"#3c3c3c"}]},{"featureType":"road.highway.controlled_access","elementType":"geometry","stylers":[{"color":"#4e4e4e"}]},{"featureType":"road.local","elementType":"labels.text.fill","stylers":[{"color":"#616161"}]},{"featureType":"transit","elementType":"labels.text.fill","stylers":[{"color":"#757575"}]},{"featureType":"water","elementType":"geometry","stylers":[{"color":"#000000"}]},{"featureType":"water","elementType":"labels.text.fill","stylers":[{"color":"#3d3d3d"}]}]');
    _mapController.complete(controller);
    await setPolylines();
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
    );

    markers[id] = marker;

  }
}