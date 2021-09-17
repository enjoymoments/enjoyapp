part of 'add_time_line_bloc.dart';

class AddTimeLineState extends DefaultState {
  final List<GalleryImageModel>? images;
  final int? forceRefresh;
  final String? textPost;

  AddTimeLineState({
    bool? isLoading,
    bool? isEmpty,
    bool? isError,
    bool? isSuccess,
    String? errorMessage,
    this.images,
    this.forceRefresh,
    this.textPost,
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
      images: [],
      forceRefresh: 0,
      textPost: null,
    );
  }

  AddTimeLineState copyWith({
    bool? isLoading,
    bool? isSuccess,
    bool? isEmpty,
    bool? isError,
    String? errorMessage,
    List<GalleryImageModel>? images,
    int? forceRefresh,
    String? textPost,
  }) {
    return AddTimeLineState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isEmpty: isEmpty ?? this.isEmpty,
      isError: isError ?? this.isError,
      errorMessage: errorMessage ?? this.errorMessage,
      forceRefresh: forceRefresh,
      images: images ?? this.images,
      textPost: textPost ?? this.textPost,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        isSuccess,
        isEmpty,
        isError,
        errorMessage,
        forceRefresh,
        images,
        textPost,
      ];
}
