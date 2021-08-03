import 'package:equatable/equatable.dart';

class Location extends Equatable {
  final double latitude;
  final double longitude;

  Location({
    this.latitude,
    this.longitude,
  });

  @override
  List<Object> get props => [
        this.latitude,
        this.longitude,
      ];
}
