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
  })  : assert(email != null),
        assert(autenticatorProviderId != null),
        assert(id != null);

  /// The current user's email address.
  final String email;

  /// The current user's id.
  final String id;

  final String autenticatorProviderId;

  /// The current user's name (display name).
  final String name;

  /// Url for the current user's photo.
  final String photo;

  /// Empty user which represents an unauthenticated user.
  static const empty = UserAppModel(
      id: '', autenticatorProviderId: '', email: '', name: null, photo: null);

  @override
  List<Object> get props => [email, id, name, photo];
}
