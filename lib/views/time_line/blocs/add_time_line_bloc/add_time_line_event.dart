part of 'add_time_line_bloc.dart';

abstract class AddTimeLineEvent extends Equatable {
  const AddTimeLineEvent();
}

class OpenMediaEvent extends AddTimeLineEvent {
  final ImageSource source;

  OpenMediaEvent(this.source);

  @override
  List<Object> get props => [
        source,
      ];
}
