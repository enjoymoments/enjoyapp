part of 'add_time_line_bloc.dart';

abstract class AddTimeLineEvent extends Equatable {
  const AddTimeLineEvent();
}

class OpenCameraEvent extends AddTimeLineEvent {
  final ImageSource source;

  OpenCameraEvent(this.source);

  @override
  List<Object> get props => [
        source,
      ];
}
