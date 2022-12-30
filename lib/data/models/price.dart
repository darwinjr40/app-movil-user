
import 'dart:convert';

class Price {
    Price({
      required this.km,
      required this.min,
      required this.minValue,
    });

    double km;
    double min;
    double minValue;

    factory Price.fromJson(String str) => Price.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Price.fromMap(Map<String, dynamic> json) => Price(
        km: json["km"].toDouble(),
        min: json["min"].toDouble(),
        minValue: json["minValue"].toDouble(),
    );

    Map<String, dynamic> toMap() => {
        "km": km,
        "min": min,
        "minValue": minValue,
    };
}
