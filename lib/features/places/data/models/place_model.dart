import 'package:mozin/features/places/domain/entities/place.dart';

class PlaceModel extends Place {
  PlaceModel({
    String address,
    String name,
    String placeId,
    double rating,
    List<String> types,
    int userRatingsTotal,
    String vicinity,
    int priceLevel,
    List<String> photoReferences,
    String icon,
  }) : super(
          address: address,
          name: name,
          placeId: placeId,
          rating: rating,
          types: types,
          userRatingsTotal: userRatingsTotal,
          vicinity: vicinity,
          priceLevel: priceLevel,
          photoReferences: photoReferences,
          icon: icon,
        );

  factory PlaceModel.fromJson(Map<String, dynamic> json) {
    return PlaceModel(
      address: json["address"],
      name: json["name"],
      placeId: json["placeId"],
      rating: json["rating"] != null ? json["rating"].toDouble() : 0,
      types: json["types"] != null ? List<String>.from(json["types"].map((x) => x)) : List(),
      userRatingsTotal: json["userRatingsTotal"],
      vicinity: json["vicinity"],
      priceLevel: json["priceLevel"] == null ? null : json["priceLevel"],
      icon: json["icon"],
      photoReferences: json["photoReferences"] != null ? List<String>.from(json["photoReferences"].map((x) => x)) : List(),
    );
  }
}
