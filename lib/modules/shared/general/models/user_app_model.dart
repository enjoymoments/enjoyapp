import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:mozin/modules/shared/general/interest_type.dart';

/// {@template user}
/// User model
///
/// [UserAppModel.empty] represents an unauthenticated user.
/// {@endtemplate}
class UserAppModel extends Equatable {
  /// {@macro user}
   const UserAppModel({
    @required this.id,
    @required this.email,
    @required this.name,
    @required this.photo,
    this.timelineId,
    this.favoriteInterests,
    this.internalId,
  })  : assert(email != null),
        assert(id != null);

  final String email;

  final String id;

  final String internalId;

  final String name;

  final String photo;

  final String timelineId;

  final InterestType favoriteInterests;

  UserAppModel copyWith({
    String timelineId,
    InterestType favoriteInterests,
    String internalId
  }) {
    return UserAppModel(
      id: this.id,
      email: this.email,
      name: this.name,
      photo: this.photo,
      timelineId: timelineId ?? this.timelineId,
      favoriteInterests: favoriteInterests ?? this.favoriteInterests,
      internalId: internalId ?? this.internalId,
    );
  }

  static const empty = UserAppModel(
    id: '',
    email: '',
    name: '',
    photo: '',
    internalId: '',
  );

  @override
  List<Object> get props => [
        email,
        id,
        name,
        photo,
        internalId,
      ];
}
