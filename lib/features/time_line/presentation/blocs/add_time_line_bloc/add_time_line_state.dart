part of 'add_time_line_bloc.dart';

class AddTimeLineState extends DefaultState {
  final List<GalleryImageModel> images;
  final int forceRefresh;

  AddTimeLineState({
    bool isLoading,
    bool isEmpty,
    bool isError,
    bool isSuccess,
    String errorMessage,
    this.images,
    this.forceRefresh,
  }) : super(
          isLoading: isLoading,
          isSuccess: isSuccess,
          isEmpty: isEmpty,
          isError: isError,
          errorMessage: errorMessage,
        );

  factory AddTimeLineState.initial() {
    return AddTimeLineState(
      isSuccess: false,
      isEmpty: false,
      isError: false,
      isLoading: false,
      errorMessage: null,
      images: List(),
      forceRefresh: 0,
    );
  }

  AddTimeLineState copyWith({
    bool isLoading,
    bool isSuccess,
    bool isEmpty,
    bool isError,
    String errorMessage,
    List<GalleryImageModel> images,
    int forceRefresh,
  }) {
    return AddTimeLineState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isEmpty: isEmpty ?? this.isEmpty,
      isError: isError ?? this.isError,
      errorMessage: errorMessage ?? this.errorMessage,
      forceRefresh: forceRefresh,
      images: images ?? this.images,
    );
  }

  @override
  List<Object> get props => [
        isLoading,
        isSuccess,
        isEmpty,
        isError,
        errorMessage,
        forceRefresh,
        images,
      ];
}
