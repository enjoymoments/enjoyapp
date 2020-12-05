part of 'place_details_bloc.dart';

abstract class PlaceDetailsEvent extends Equatable {
  const PlaceDetailsEvent();

  @override
  List<Object> get props => [];
}

class LoadDetails extends PlaceDetailsEvent {
  PlaceModel item;

  LoadDetails(this.item);
}

class LoadPhotos extends PlaceDetailsEvent {
  final PlaceModel item;

  LoadPhotos(this.item);
}
