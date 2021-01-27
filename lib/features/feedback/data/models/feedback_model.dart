import 'package:mozin/features/feedback/domain/entities/feedback.dart';

class FeedbackModel extends Feedback {
  
  const FeedbackModel();
  // const FeedbackModel(
  //     {})
  //     : super();

  factory FeedbackModel.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> data = <String, dynamic>{};
    data = json;
    
    return FeedbackModel(
      
    );
  }

  @override
  String toString() {
    return '''
    ''';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    return data;
  }

  FeedbackModel copyWith() {
    return FeedbackModel();
  }
}
