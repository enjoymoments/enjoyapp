import 'package:mozin/features/places/domain/entities/places.dart';

class PlacesModel extends Places {
  
  const PlacesModel();
  // const PlacesModel(
  //     {})
  //     : super();

  factory PlacesModel.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> data = <String, dynamic>{};
    data = json;
    
    return PlacesModel(
      
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

  PlacesModel copyWith() {
    return PlacesModel();
  }
}
