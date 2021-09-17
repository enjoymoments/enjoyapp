part of 'place_photos_bloc.dart';

abstract class PlacePhotosEvent extends Equatable {
  const PlacePhotosEvent();

  @override
  List<Object> get props => [];
}

class LoadPhotos extends PlacePhotosEvent {
  final PlaceModel? item;

  LoadPhotos(this.item);
}