import 'package:geolocator/geolocator.dart';

class Address {

  // street includes street number
  String street, zip, city;
  Position geolocation;

  Address({this.street = '', this.zip = '', this.city = '', this.geolocation });

  factory Address.fromJSON(json) => Address(
    street: json['streetName'] ?? '',
    zip: json['zip'] ?? '',
    city: json['city'] ?? '',
    geolocation: Position.fromMap(json['geolocation']) ?? null,
  );

  Map toJSON() => {
    'streetName': street,
    'zip': zip,
    'city': city,
    'geolocation': geolocation?.toJson() ?? null,
  };

  setAddress({street, zip, city}) {
    if (street != null) this.street = street;
    if (zip != null) this.zip = zip;
    if (city != null) this.city = city;
  }

}