import 'package:equatable/equatable.dart';

class UserSyncInfo extends Equatable {
  
  const UserSyncInfo({
    this.name,
    this.photo,
  });
  
  final String name;
  final String photo;

  @override
  List<Object> get props => <Object>[
    name,
    photo,
  ];
}
