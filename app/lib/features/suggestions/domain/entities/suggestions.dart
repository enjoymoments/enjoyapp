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
    this.url,
  });

  final String? title;
  final String? description;
  final String? id;
  final int? like;
  final int? dislike;
  final bool? moreOptionsEnable;
  final String? url;
  bool? favoriteAdded;

  @override
  List<Object?> get props => <Object?>[
        title,
        description,
        id,
        like,
        dislike,
        moreOptionsEnable,
        favoriteAdded,
        url,
      ];
}
