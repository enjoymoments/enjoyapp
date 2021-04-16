import 'package:mozin/features/invite/domain/entities/invite.dart';

class InviteModel extends Invite {
  
  const InviteModel();
  // const InviteModel(
  //     {})
  //     : super();

  factory InviteModel.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> data = <String, dynamic>{};
    data = json;
    
    return InviteModel(
      
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

  InviteModel copyWith() {
    return InviteModel();
  }
}
