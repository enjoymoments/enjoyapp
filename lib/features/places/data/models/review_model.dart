import 'package:mozin/features/places/domain/entities/review.dart';

class ReviewModel extends Review {
  ReviewModel({
    String authorName,
    String profilePhotoUrl,
    int rating,
    String relativeTimeDescription,
    String text,
    int time,
  }) : super(
          authorName: authorName,
          profilePhotoUrl: profilePhotoUrl,
          rating: rating,
          relativeTimeDescription: relativeTimeDescription,
          text: text,
          time: time,
        );

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      authorName: json["authorName"],
      profilePhotoUrl: json["profilePhotoUrl"],
      rating: json["rating"],
      relativeTimeDescription: json["relativeTimeDescription"],
      text: json["text"],
      time: json["time"],
    );
  }
}
