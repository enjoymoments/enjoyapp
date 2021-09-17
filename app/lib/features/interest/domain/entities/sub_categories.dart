import 'package:equatable/equatable.dart';

class SubCategories extends Equatable {
  const SubCategories({
    this.id,
    this.name,
  });

  final String? id;
  final String? name;

  @override
  List<Object?> get props => <Object?>[
        id,
        name,
      ];
}
