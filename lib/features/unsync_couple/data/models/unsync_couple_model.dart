import 'package:mozin/features/unsync_couple/domain/entities/unsync_couple.dart';

class UnsyncCoupleModel extends UnsyncCouple {
  
  const UnsyncCoupleModel();
  // const UnsyncCoupleModel(
  //     {})
  //     : super();

  factory UnsyncCoupleModel.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> data = <String, dynamic>{};
    data = json;
    
    return UnsyncCoupleModel(
      
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

  UnsyncCoupleModel copyWith() {
    return UnsyncCoupleModel();
  }
}
