import 'package:equatable/equatable.dart';
import 'package:mozin/features/places/domain/entities/places_sub_category.dart';

class PlacesCategory extends Equatable {
  const PlacesCategory({
    this.categoryName,
    this.subCategories
  });

  final List<PlacesSubCategory> subCategories;
  final String categoryName;

  @override
  List<Object> get props => <Object>[
        categoryName,
        subCategories,
      ];
}
