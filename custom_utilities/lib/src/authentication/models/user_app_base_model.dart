import 'package:equatable/equatable.dart';

/// {@template user}
/// User model
///
/// [UserAppModel.empty] represents an unauthenticated user.
/// {@endtemplate}
class UserAppBaseModel extends Equatable {
  /// {@macro user}
  const UserAppBaseModel({
    required this.id,
    required this.email,
    required this.name,
    required this.photo,
  })  : assert(email != null),
        assert(id != null);

  final String email;

  final String id;

  final String? name;

  final String? photo;

  factory UserAppBaseModel.initial() {
    return UserAppBaseModel(
      id: '',
      email: '',
      name: '',
      photo: '',
    );
  }

  factory UserAppBaseModel.empty() {
    return UserAppBaseModel(
      id: '',
      email: '',
      name: '',
      photo: '',
    );
  }

  UserAppBaseModel copyWith() {
    return UserAppBaseModel(
      id: this.id,
      email: this.email,
      name: this.name,
      photo: this.photo,
    );
  }

  @override
  List<Object?> get props => [
        email,
        id,
        name,
        photo,
      ];
}
