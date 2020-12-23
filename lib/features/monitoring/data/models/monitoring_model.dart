import 'package:mozin/features/monitoring/domain/entities/monitoring.dart';

class MonitoringModel extends Monitoring {
  
  const MonitoringModel();
  // const MonitoringModel(
  //     {})
  //     : super();

  factory MonitoringModel.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> data = <String, dynamic>{};
    data = json;
    
    return MonitoringModel(
      
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

  MonitoringModel copyWith() {
    return MonitoringModel();
  }
}
