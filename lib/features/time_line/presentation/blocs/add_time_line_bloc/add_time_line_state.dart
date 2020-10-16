part of 'add_time_line_bloc.dart';

class AddTimeLineState extends Equatable {
  final bool isLoading;
  final List<GalleryImageModel> images;
  final bool isSuccess;
  final bool isFailure;
  final int forceRefresh;

  AddTimeLineState({
    this.isLoading,
    this.images,
    this.isSuccess,
    this.isFailure,
    this.forceRefresh,
  });

  factory AddTimeLineState.initial() {
    return AddTimeLineState(
      isLoading: false,
      images: List(),
      isSuccess: false,
      isFailure: false,
      forceRefresh: 0,
    );
  }

  AddTimeLineState copyWith({
    bool isLoading,
    bool isSuccess,
    bool isFailure,
    List<GalleryImageModel> images,
    int forceRefresh,
  }) {
    return AddTimeLineState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
      forceRefresh: forceRefresh,
      images: images,
    );
  }

  @override
  List<Object> get props => [
        isLoading,
        isSuccess,
        isFailure,
        forceRefresh,
        images,
      ];
}
