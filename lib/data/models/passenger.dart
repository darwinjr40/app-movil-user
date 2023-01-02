
import 'dart:convert';

class Passenger {
  
    Passenger({
        required this.token,
        required this.id,
    });

    int id;
    String token;

    factory Passenger.fromJson(String str) => Passenger.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Passenger.fromMap(Map<String, dynamic> json) => Passenger(
        token: json["token"],
        id: json["id"],
    );

    Map<String, dynamic> toMap() => {
        "token": token,
        "id": id,
    };
}
