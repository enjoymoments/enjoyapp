import 'package:equatable/equatable.dart';
import 'package:mozin/features/interest/domain/entities/sub_categories.dart';

class Categories extends Equatable {
  const Categories({
    this.id,
    this.name,
    this.subCategories,
  });

  final String id;
  final String name;
  final List<SubCategories> subCategories;

  @override
  List<Object> get props => <Object>[
        id,
        name,
        subCategories,
      ];
}
