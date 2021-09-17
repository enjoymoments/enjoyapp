import 'package:mozin/features/places/domain/entities/location.dart';

class LocationModel extends Location {
  LocationModel({
    double? latitude,
    double? longitude,
  }) : super(
          latitude: latitude,
          longitude: longitude,
        );

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      latitude: json["latitude"],
      longitude: json["longitude"],
    );
  }
}
