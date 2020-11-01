import 'package:equatable/equatable.dart';
import 'package:mozin/features/places/domain/entities/place.dart';

class Places extends Equatable {
  const Places({
    this.places,
  });

  final List<Place> places;

  @override
  List<Object> get props => <Object>[
        places,
      ];
}
