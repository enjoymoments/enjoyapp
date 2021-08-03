import 'package:mozin/features/favoriteinterests/domain/entities/favorite_interests.dart';

class FavoriteInterestsModel extends FavoriteInterests {
  
  const FavoriteInterestsModel();
  // const FavoriteInterestsModel(
  //     {})
  //     : super();

  factory FavoriteInterestsModel.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> data = <String, dynamic>{};
    data = json;
    
    return FavoriteInterestsModel(
      
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

  FavoriteInterestsModel copyWith() {
    return FavoriteInterestsModel();
  }
}
