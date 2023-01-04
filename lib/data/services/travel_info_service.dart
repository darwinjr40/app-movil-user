import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:micros_user_app/data/models/models.dart';
import 'package:micros_user_app/env.dart';
import 'package:http/http.dart' as http;

class TravelInfoService {

  // CollectionReference _ref;

  // TravelInfoProvider() {
    // _ref = FirebaseFirestore.instance.collection('TravelInfo');
  // }
  late Timer timer;
  
  Future<void> createOrUpdate(TravelInfo travelInfo) async {
    try {
      // return _ref.doc(travelInfo.id).set(travelInfo.toJson());
      debugPrint(travelInfo.toMap().toString());
      final url = '${baseUrl}travel-info/update/${travelInfo.idCode}';
      final resp = await http.put(
        Uri.parse(url),
        headers: {'Accept' : 'application/json'},
        body: travelInfo.toMap(),
      );
      // final Map<String, dynamic> decodedResp = json.decode(resp.body);
      if (resp.statusCode != 200) {
        debugPrint(resp.body);
      }            
        debugPrint("chill------------------------------------");
    } catch(error) {
      debugPrint(error.toString());
      return Future.error(error.toString());
    }

  }

  Stream<TravelInfo> getByIdStream(String id) {
    final url = '${baseUrl}travel-info/get/$id';
    final controller = StreamController<TravelInfo>();
    try {
      timer = Timer.periodic(const Duration(seconds: 5), (timer) {
        // Realizamos la conexión al servidor
        http.get(
          Uri.parse(url),
          headers: {'Accept' : 'application/json'},
        ).then((response) {
          // Emitimos los datos recibidos en el stream
            debugPrint("1-----------${response.body}");
          if (response.statusCode != 200) {
            debugPrint(response.body);
          } else {
            final travel = TravelInfo.fromJson(response.body);
            controller.add(travel);
          }     
          // Cerramos el stream cuando se haya recibido toda la respuesta
          // controller.close();
        }).catchError((error) {
          // Emitimos un error en el stream si ocurre algún problema
          controller.addError(error);
        });    
      });
    } catch(error) {
      debugPrint('TRY CACH ERROR <TravelInfoService> getByIdStream $error');
    }
      return controller.stream; 
  }
  

}