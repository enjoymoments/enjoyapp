import 'package:equatable/equatable.dart';

class Suggestions extends Equatable {
  Suggestions({
    this.title,
    this.description,
    this.id,
    this.like,
    this.dislike,
    this.moreOptionsEnable,
    this.favoriteAdded,
  });

  final String title;
  final String description;
  final String id;
  final int like;
  final int dislike;
  final bool moreOptionsEnable;
  bool favoriteAdded;

  @override
  List<Object> get props => <Object>[
        title,
        description,
        id,
        like,
        dislike,
        moreOptionsEnable,
        favoriteAdded,
      ];
}
