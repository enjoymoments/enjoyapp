import 'package:equatable/equatable.dart';
import 'package:mozin/features/places/domain/entities/place.dart';

class PlacesSubCategory extends Equatable {
  const PlacesSubCategory({
    this.subCategoryName,
    this.data,
  });

  final List<Place> data;
  final String subCategoryName;

  @override
  List<Object> get props => <Object>[
        subCategoryName,
        data,
      ];
}
