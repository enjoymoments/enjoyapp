import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

/// {@template user}
/// User model
///
/// [UserAppModel.empty] represents an unauthenticated user.
/// {@endtemplate}
class UserAppModel extends Equatable {
  /// {@macro user}
  const UserAppModel({
    @required this.id,
    @required this.autenticatorProviderId,
    @required this.email,
    @required this.name,
    @required this.photo,
    this.timelineId,
  })  : assert(email != null),
        assert(autenticatorProviderId != null),
        assert(id != null);

  final String email;

  final String id;

  final String autenticatorProviderId;

  final String name;

  final String photo;

  final String timelineId;

  UserAppModel copyWith(String timelineId) {
    return UserAppModel(
      id: this.id,
      autenticatorProviderId: this.autenticatorProviderId,
      email: this.email,
      name: this.name,
      photo: this.photo,
      timelineId: timelineId,
    );
  }

  static const empty = UserAppModel(
      id: '', autenticatorProviderId: '', email: '', name: '', photo: '');

  @override
  List<Object> get props => [email, id, name, photo];
}
