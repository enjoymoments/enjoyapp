part of 'gpsopen_cubit.dart';

abstract class GpsOpenState extends Equatable {
  const GpsOpenState();

  @override
  List<Object> get props => [];
}

class GpsOpenInitial extends GpsOpenState {}

class GpsElements extends  GpsOpenState {
  final Widget elements;

  GpsElements(this.elements);
}
