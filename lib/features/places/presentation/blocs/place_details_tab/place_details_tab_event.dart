import 'package:equatable/equatable.dart';

abstract class PlaceDetailsTabEvent extends Equatable {
  const PlaceDetailsTabEvent();

  @override
  List<Object> get props => [];
}

class ChangeTabEvent extends PlaceDetailsTabEvent {
  final int newTab;

  ChangeTabEvent(this.newTab);
}
