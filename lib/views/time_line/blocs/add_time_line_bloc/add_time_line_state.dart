part of 'add_time_line_bloc.dart';

class AddTimeLineState extends Equatable {
  final bool isLoading;
  final List<GalleryImageModel> images;

  AddTimeLineState({
    this.isLoading,
    this.images,
  });

  factory AddTimeLineState.initial() {
    return AddTimeLineState(
      isLoading: false,
      images: List(),
    );
  }

  AddTimeLineState copyWith({
    bool isLoading,
    List<GalleryImageModel> images,
  }) {
    return AddTimeLineState(
      isLoading: isLoading ?? this.isLoading,
      images: images ?? this.images,
    );
  }

  @override
  List<Object> get props => [
        isLoading,
        images,
      ];
}
