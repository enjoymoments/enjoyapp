part of 'place_details_bloc.dart';

abstract class PlaceDetailsEvent extends Equatable {
  const PlaceDetailsEvent();

  @override
  List<Object> get props => [];
}

class LoadDetails extends PlaceDetailsEvent {
  PlaceModel? item;
  PlacePhotosBloc? placePhotosBloc;
  FavoriteInterestsItemBloc? favoriteInterestsItemBloc;

  LoadDetails(this.item, this.favoriteInterestsItemBloc, this.placePhotosBloc);
}
