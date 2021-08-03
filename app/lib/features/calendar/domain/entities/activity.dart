import 'package:equatable/equatable.dart';
import 'package:mozin/features/calendar/domain/entities/activity_item.dart';

class Activity extends Equatable {
  
  const Activity({
    this.id,
    this.sessionName,
    this.activities,
  });

  final String id;
  final String sessionName;
  final List<ActivityItem> activities;

  @override
  List<Object> get props => <Object>[
    this.id,
    this.sessionName,
    this.activities,
  ];
}
