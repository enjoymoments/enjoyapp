import 'package:equatable/equatable.dart';

class Suggestions extends Equatable {
  const Suggestions({
    this.title,
    this.description,
    this.id,
    this.like,
    this.dislike,
  });

  final String title;
  final String description;
  final String id;
  final int like;
  final int dislike;

  @override
  List<Object> get props => <Object>[
        title,
        description,
        id,
        like,
        dislike,
      ];
}
