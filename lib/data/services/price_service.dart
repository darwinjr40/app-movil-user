import 'dart:convert';
// import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:micros_user_app/data/models/models.dart';
import 'package:micros_user_app/env.dart';

class PriceService {

  // CollectionReference _ref;

  // PricesProvider() {
    // _ref = FirebaseFirestore.instance.collection('Prices');
  // }

  Future<Price> getAll() async {
    // DocumentSnapshot document = await _ref.doc('info').get();
    // Prices prices = Prices.fromJson(document.data());
    // return prices;
    const url = (baseUrl + 'bus/all');
    final response = await http.get(Uri.parse(url));
    final decodedData = json.decode(response.body);
    final leg =  Price.fromMap(decodedData);
    return leg;
  }

}