import 'package:equatable/equatable.dart';
import 'package:mozin/features/places/domain/entities/place.dart';
import 'package:mozin/features/suggestions/domain/entities/suggestions.dart';

class PlacesSubCategory extends Equatable {
  const PlacesSubCategory({
    this.subCategoryId,
    this.subCategoryName,
    this.places,
    this.suggestedByUsers,
  });

  final List<Place?>? places;
  final List<Suggestions>? suggestedByUsers;
  final String? subCategoryName;
  final String? subCategoryId;

  @override
  List<Object?> get props => <Object?>[
        subCategoryId,
        subCategoryName,
        places,
        suggestedByUsers,
      ];
}
