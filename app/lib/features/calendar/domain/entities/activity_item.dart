import 'package:equatable/equatable.dart';

class ActivityItem extends Equatable {
  ActivityItem({
    this.id,
    this.name,
    this.codePoint,
    this.isSelected,
  });

  final String? id;
  final String? name;
  final int? codePoint;
  final bool? isSelected;

  @override
  List<Object?> get props => <Object?>[
        this.id,
        this.name,
        this.codePoint,
        this.isSelected,
      ];
}
