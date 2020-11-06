import 'package:equatable/equatable.dart';

class Place extends Equatable {
  final String address;
  final String name;
  final String placeId;
  final double rating;
  final List<String> types;
  final int userRatingsTotal;
  final String vicinity;
  final int priceLevel;
  final List<String> photoReferences;
  final String icon;

  Place({
    this.address,
    this.name,
    this.placeId,
    this.rating,
    this.types,
    this.userRatingsTotal,
    this.vicinity,
    this.priceLevel,
    this.photoReferences,
    this.icon,
  });

  @override
  List<Object> get props => [
        this.address,
        this.name,
        this.placeId,
        this.rating,
        this.types,
        this.userRatingsTotal,
        this.vicinity,
        this.priceLevel,
        this.photoReferences,
        this.icon,
      ];
}
