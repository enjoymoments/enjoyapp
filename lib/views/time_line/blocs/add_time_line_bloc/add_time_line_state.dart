part of 'add_time_line_bloc.dart';

class AddTimeLineState extends Equatable {
  final bool isLoading;
  final List<File> medias;

  AddTimeLineState({
    this.isLoading,
    this.medias,
  });

  factory AddTimeLineState.initial() {
    return AddTimeLineState(
      isLoading: false,
      medias: List(),
    );
  }

  AddTimeLineState copyWith({
    bool isLoading,
    List<File> medias,
  }) {
    return AddTimeLineState(
      isLoading: isLoading ?? this.isLoading,
      medias: medias ?? this.medias,
    );
  }

  @override
  List<Object> get props => [
        isLoading,
        medias,
      ];
}
