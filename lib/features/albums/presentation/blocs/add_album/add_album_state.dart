part of 'add_album_cubit.dart';

class AddAlbumState extends DefaultState {
  AddAlbumState({
    bool isLoading,
    bool isEmpty,
    bool isError,
    bool isSuccess,
    String errorMessage,
    this.images,
    this.albums,
    this.forceRefresh,
  }) : super(
          isLoading: isLoading,
          isSuccess: isSuccess,
          isEmpty: isEmpty,
          isError: isError,
          errorMessage: errorMessage,
        );

  final List<GalleryImageModel> images;
  final List<AlbumItemModel> albums;
  final int forceRefresh;

  factory AddAlbumState.initial() {
    return AddAlbumState(
      isSuccess: false,
      isEmpty: false,
      isError: false,
      isLoading: false,
      errorMessage: null,
      images: List(),
      albums: List(),
      forceRefresh: null,
    );
  }

  AddAlbumState copyWith({
    bool isLoading,
    bool isSuccess,
    bool isEmpty,
    bool isError,
    String errorMessage,
    List<GalleryImageModel> images,
    List<AlbumItemModel> albums,
    int forceRefresh,
  }) {
    return AddAlbumState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isEmpty: isEmpty ?? this.isEmpty,
      isError: isError ?? this.isError,
      errorMessage: errorMessage ?? this.errorMessage,
      images: images ?? this.images,
      albums: albums ?? this.albums,
      forceRefresh: forceRefresh ?? this.forceRefresh,
    );
  }

  @override
  List<Object> get props => [
        isLoading,
        isSuccess,
        isEmpty,
        isError,
        errorMessage,
        images,
        albums,
        forceRefresh,
      ];
}
