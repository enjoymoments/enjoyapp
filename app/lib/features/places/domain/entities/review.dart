import 'package:equatable/equatable.dart';

class Review extends Equatable {
  final String? authorName;
  final String? profilePhotoUrl;
  final int? rating;
  final String? relativeTimeDescription;
  final String? text;
  final int? time;

  Review({
    this.authorName,
    this.profilePhotoUrl,
    this.rating,
    this.relativeTimeDescription,
    this.text,
    this.time,
  });

  @override
  List<Object?> get props => [
        this.authorName,
        this.profilePhotoUrl,
        this.rating,
        this.relativeTimeDescription,
        this.text,
        this.time,
      ];
}
