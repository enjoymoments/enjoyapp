part of 'add_time_line_bloc.dart';

class AddTimeLineState extends Equatable {
  final bool isLoading;
  final List<GalleryImageModel> images;
  final bool isSuccess;
  final bool isFailure;

  AddTimeLineState({
    this.isLoading,
    this.images,
    this.isSuccess,
    this.isFailure,
  });

  factory AddTimeLineState.initial() {
    return AddTimeLineState(
      isLoading: false,
      images: List(),
      isSuccess: false,
      isFailure: false,
    );
  }

  AddTimeLineState copyWith({
    bool isLoading,
    bool isSuccess,
    bool isFailure,
    List<GalleryImageModel> images,
  }) {
    return AddTimeLineState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
      images: images ?? this.images,
    );
  }

  @override
  List<Object> get props => [
        isLoading,
        isSuccess,
        isFailure,
        images,
      ];
}
