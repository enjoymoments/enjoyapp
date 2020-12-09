import 'package:mozin/features/places/data/models/location_model.dart';
import 'package:mozin/features/places/data/models/review_model.dart';
import 'package:mozin/features/places/domain/entities/place.dart';
import 'package:mozin/features/places/domain/entities/review.dart';

class PlaceModel extends Place {
  PlaceModel({
    String address,
    String formattedAddress,
    String formattedPhoneNumber,
    String name,
    String placeId,
    double rating,
    List<String> types,
    int userRatingsTotal,
    String vicinity,
    int priceLevel,
    List<String> photoReferences,
    String icon,
    LocationModel location,
    bool openNow,
    List<Review> reviews,
  }) : super(
          address: address,
          formattedAddress: formattedAddress,
          formattedPhoneNumber: formattedPhoneNumber,
          name: name,
          placeId: placeId,
          rating: rating,
          types: types,
          userRatingsTotal: userRatingsTotal,
          vicinity: vicinity,
          priceLevel: priceLevel,
          photoReferences: photoReferences,
          icon: icon,
          location: location,
          openNow: openNow,
          reviews: reviews,
        );

  factory PlaceModel.fromJson(Map<String, dynamic> json) {
    return PlaceModel(
      address: json["address"],
      name: json["name"],
      placeId: json["placeId"],
      rating: json["rating"] != null ? json["rating"].toDouble() : 0,
      types: json["types"] != null
          ? List<String>.from(json["types"].map((x) => x))
          : List(),
      userRatingsTotal: json["userRatingsTotal"],
      vicinity: json["vicinity"],
      priceLevel: json["priceLevel"] == null ? null : json["priceLevel"],
      icon: json["icon"],
      location: json['location'] != null
          ? LocationModel.fromJson(json['location'])
          : null,
    );
  }

  factory PlaceModel.fromJsonComplement(
      PlaceModel place, Map<String, dynamic> json) {
    place.formattedAddress = json['formattedAddress'];
    place.formattedPhoneNumber = json['formattedPhoneNumber'];
    place.openNow = json['openNow'];
    place.photoReferences = json["photoReferences"] != null
          ? List<String>.from(json["photoReferences"].map((x) => x))
          : List();
    place.reviews = json["reviews"] != null
        ? List<ReviewModel>.from(
            json["reviews"].map((x) => ReviewModel.fromJson(x)))
        : List();

    return place;
  }
}
