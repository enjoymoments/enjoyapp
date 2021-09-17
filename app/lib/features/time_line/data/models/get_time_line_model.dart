import 'package:mozin/modules/shared/general/enums.dart';

class GetTimeLineModel {
  String? id;
  TimeLineTypeEnum? type;

  GetTimeLineModel({
    this.id,
    this.type,
  });

    factory GetTimeLineModel.fromJson(Map<String, dynamic> json) {
    return GetTimeLineModel(
      id: json['id'],
      type: TimeLineTypeEnum(json['type']),
    );
  }
}
