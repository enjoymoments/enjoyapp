import 'package:equatable/equatable.dart';
import 'package:mozin/features/places/domain/entities/location.dart';
import 'package:mozin/features/places/domain/entities/review.dart';

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
  final Location location;
  bool openNow;
  List<Review> reviews;

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
    this.location,
    this.openNow,
    this.reviews,
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
        this.location,
        this.openNow,
        this.reviews,
      ];
}
