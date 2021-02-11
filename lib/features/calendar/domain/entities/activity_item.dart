import 'package:equatable/equatable.dart';

class ActivityItem extends Equatable {
  const ActivityItem({
    this.id,
    this.name,
    this.codePoint,
  });

  final String id;
  final String name;
  final int codePoint;

  @override
  List<Object> get props => <Object>[
        this.id,
        this.name,
        this.codePoint,
      ];
}
