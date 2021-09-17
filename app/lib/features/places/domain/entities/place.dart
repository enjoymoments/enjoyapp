import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:mozin/features/places/domain/entities/location.dart';
import 'package:mozin/features/places/domain/entities/review.dart';

class Place extends Equatable {
  final String? address;
  String? formattedAddress;
  String? formattedPhoneNumber;
  final String? name;
  bool? favorited;
  final String? placeId;
  final double? rating;
  final List<String>? types;
  final int? userRatingsTotal;
  final String? vicinity;
  final int? priceLevel;
  List<String>? photoReferences;
  final String? icon;
  final Location? location;
  bool? openNow;
  List<Review>? reviews;
  List<Uint8List>? photos;

  Place({
    this.address,
    this.formattedAddress,
    this.formattedPhoneNumber,
    this.name,
    this.favorited,
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
    this.photos,
  });

  @override
  List<Object?> get props => [
        this.address,
        this.formattedAddress,
        this.formattedPhoneNumber,
        this.name,
        this.favorited,
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
        this.photos,
      ];
}
