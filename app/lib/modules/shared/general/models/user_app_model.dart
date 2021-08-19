import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:mozin/features/time_line/data/models/get_time_line_model.dart';
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
    this.timelines,
    this.timelineSelected,
    this.favoriteInterests,
  })  : assert(email != null),
        assert(id != null);

  final String email;

  final String id;

  final String name;

  final String photo;

  final List<GetTimeLineModel> timelines;
  final GetTimeLineModel timelineSelected;

  final InterestType favoriteInterests;

  UserAppModel copyWith({
    List<GetTimeLineModel> timelines,
    GetTimeLineModel timelineSelected,
    InterestType favoriteInterests,
  }) {
    return UserAppModel(
      id: this.id,
      email: this.email,
      name: this.name,
      photo: this.photo,
      timelines: timelines ?? this.timelines,
      timelineSelected: timelineSelected ?? this.timelineSelected,
      favoriteInterests: favoriteInterests ?? this.favoriteInterests,
    );
  }

  static const empty = UserAppModel(
    id: '',
    email: '',
    name: '',
    photo: '',
  );

  @override
  List<Object> get props => [
        email,
        id,
        name,
        photo,
      ];
}