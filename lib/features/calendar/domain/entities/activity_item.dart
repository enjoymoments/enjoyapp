import 'package:equatable/equatable.dart';

class ActivityItem extends Equatable {
  const ActivityItem({
    this.id,
    this.name,
  });

  final String id;
  final String name;

  @override
  List<Object> get props => <Object>[
        this.id,
        this.name,
      ];
}
