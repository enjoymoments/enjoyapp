import 'package:mozin/features/feedback/domain/entities/feedback.dart';

class FeedbackModel extends Feedback {
  
  FeedbackModel({this.description, this.userEmail, this.feedbackType});

  String description;
  String userEmail;
  int feedbackType;

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
    return {
      'description': description,
      'userEmail': userEmail,
      'feedbackType': feedbackType,
    };
  }

  FeedbackModel copyWith() {
    return FeedbackModel();
  }
}
