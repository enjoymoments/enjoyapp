import 'package:mozin/features/invite/domain/entities/user_sync_info.dart';

class UserSyncInfoModel extends UserSyncInfo {
  const UserSyncInfoModel({
    String name,
    String photo,
    this.userSyncInfoId,
  }) : super(
          name: name,
          photo: photo,
        );

  final String userSyncInfoId;

  factory UserSyncInfoModel.fromJson(Map<String, dynamic> json, String userSyncInfoId) {
    return UserSyncInfoModel(
      name: json['name'],
      photo: json['photo'],
      userSyncInfoId: userSyncInfoId,
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

  UserSyncInfoModel copyWith() {
    return UserSyncInfoModel();
  }
}
