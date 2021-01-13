import 'package:equatable/equatable.dart';
import 'package:mozin/features/places/domain/entities/places_category.dart';

class Places extends Equatable {
  const Places({
    this.places,
  });

  final List<PlacesCategory> places;

  @override
  List<Object> get props => <Object>[
        places,
      ];
}
