import 'package:mozin/features/albums/domain/entities/albums.dart';

class AlbumsModel extends Albums {
  
  const AlbumsModel();
  // const AlbumsModel(
  //     {})
  //     : super();

  factory AlbumsModel.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> data = <String, dynamic>{};
    data = json;
    
    return AlbumsModel(
      
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

  AlbumsModel copyWith() {
    return AlbumsModel();
  }
}
