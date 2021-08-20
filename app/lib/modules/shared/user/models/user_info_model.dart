import 'package:mozin/features/time_line/data/models/get_time_line_model.dart';

class UserInfoModel {
  final String userInternalId;
  final String coupleId;
  final List<GetTimeLineModel> timelines;

  UserInfoModel({
    this.userInternalId,
    this.coupleId,
    this.timelines,
  });

  factory UserInfoModel.fromJson(Map<String, dynamic> json) {
    List<GetTimeLineModel> _timelines = [];
    if (json['timelines'] != null) {
      json['timelines'].forEach((dynamic v) {
        _timelines.add(GetTimeLineModel.fromJson(v));
      });
    }

    return UserInfoModel(
      userInternalId: json['userInternalId'],
      coupleId: json['coupleId'],
      timelines: _timelines,
    );
  }
}
