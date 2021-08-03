import 'package:equatable/equatable.dart';

class AddActivityCalendar extends Equatable {
  const AddActivityCalendar({
    this.sessionId,
    this.activityId,
  });

  final String sessionId;
  final String activityId;

  @override
  List<Object> get props => <Object>[
        sessionId,
        activityId,
      ];
}
