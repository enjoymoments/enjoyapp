class UserInfoModel {
  final String userInternalId;
  final String coupleId;

  UserInfoModel({
    this.userInternalId,
    this.coupleId,
  });

  factory UserInfoModel.fromJson(Map<String, dynamic> json) {
    return UserInfoModel(
      userInternalId: json['userInternalId'],
      coupleId: json['coupleId'],
    );
  }
}
