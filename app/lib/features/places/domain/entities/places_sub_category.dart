import 'package:equatable/equatable.dart';
import 'package:mozin/features/places/domain/entities/place.dart';

class PlacesSubCategory extends Equatable {
  const PlacesSubCategory({
    this.subCategoryId,
    this.subCategoryName,
    this.places,
  });

  final List<Place> places;
  final String subCategoryName;
  final String subCategoryId;

  @override
  List<Object> get props => <Object>[
        subCategoryId,
        subCategoryName,
        places,
      ];
}
