import 'package:equatable/equatable.dart';
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
    required this.id,
    required this.email,
    required this.name,
    required this.photo,
    this.timelines,
    this.timelineSelected,
    this.favoriteInterests,
  })  : assert(email != null),
        assert(id != null);

  final String email;

  final String id;

  final String? name;

  final String? photo;

  final List<GetTimeLineModel>? timelines;
  final GetTimeLineModel? timelineSelected;

  final InterestType? favoriteInterests;

  factory UserAppModel.initial() {
    return UserAppModel(
      id: '',
      email: '',
      name: '',
      photo: '',
      favoriteInterests: InterestType(places: []),
    );
  }

  factory UserAppModel.empty() {
    return UserAppModel(
      id: '',
      email: '',
      name: '',
      photo: '',
    );
  }

  UserAppModel copyWith({
    List<GetTimeLineModel>? timelines,
    GetTimeLineModel? timelineSelected,
    InterestType? favoriteInterests,
    bool acceptValueNull = false,
  }) {
    return UserAppModel(
      id: this.id,
      email: this.email,
      name: this.name,
      photo: this.photo,
      timelines: timelines ?? this.timelines,
      timelineSelected:
          _getValue(timelineSelected, this.timelineSelected, acceptValueNull),
      favoriteInterests: favoriteInterests ?? this.favoriteInterests,
    );
  }

  @override
  List<Object?> get props => [
        email,
        id,
        name,
        photo,
      ];

  dynamic _getValue(
      dynamic newValue, dynamic defaultValue, bool acceptValueNull) {
    if (newValue != null) {
      return newValue;
    }

    if (acceptValueNull) {
      return null;
    }

    return defaultValue;
  }
}
