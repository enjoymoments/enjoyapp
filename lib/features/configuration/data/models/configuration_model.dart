import 'package:mozin/features/configuration/domain/entities/configuration.dart';

class ConfigurationModel extends Configuration {
  
  const ConfigurationModel();
  // const ConfigurationModel(
  //     {})
  //     : super();

  factory ConfigurationModel.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> data = <String, dynamic>{};
    data = json;
    
    return ConfigurationModel(
      
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

  ConfigurationModel copyWith() {
    return ConfigurationModel();
  }
}
