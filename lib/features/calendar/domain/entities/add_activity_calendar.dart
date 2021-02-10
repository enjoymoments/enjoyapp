import 'package:equatable/equatable.dart';

class AddActivityCalendar extends Equatable {
  const AddActivityCalendar({
    this.sessionId,
    this.activityId,
  });

  final String sessionId;
  final DateTime activityId;

  @override
  List<Object> get props => <Object>[
        sessionId,
        activityId,
      ];
}
