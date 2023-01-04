import 'dart:convert';

class TravelInfo {
    TravelInfo({
        required this.idCode,
        required this.status,
        this.idDriver = '-',
        required this.from,
        required this.to,
        this.idTravelHistory = '-',
        required this.fromLat,
        required this.fromLng,
        required this.toLat,
        required this.toLng,
        this.price = 0,
    });

    String idCode;
    String status;
    String idDriver;
    String from;
    String to;
    String idTravelHistory;
    double fromLat;
    double fromLng;
    double toLat;
    double toLng;
    double price;

    factory TravelInfo.fromJson(String str) => TravelInfo.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory TravelInfo.fromMap(Map<String, dynamic> json) => TravelInfo(
        idCode:             json["idCode"]  ??  '',
        status:             json["status"]  ??  '',
        idDriver:           json["idDriver"]  ??  '',
        from:               json["from"]  ??  '',
        to:                 json["to"]  ??  '',
        idTravelHistory:    json["idTravelHistory"] ??'',
        fromLat:            double.parse(json["fromLat"]),
        fromLng:            double.parse(json["fromLng"]),
        toLat:              double.parse(json["toLat"]),
        toLng:              double.parse(json["toLng"]),
        price:              double.parse(json["price"]),
    );

    Map<String, String> toMap() => {
        "idCode": idCode,
        "status": status,
        "idDriver": idDriver,
        "from": from,
        "to": to,
        "idTravelHistory": idTravelHistory,
        "fromLat": fromLat.toString(),
        "fromLng": fromLng.toString(),
        "toLat": toLat.toString(),
        "toLng": toLng.toString(),
        "price": price.toString(),
    };

    
}
