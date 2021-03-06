part of 'add_album_cubit.dart';

class AddAlbumState extends DefaultState {
  AddAlbumState({
    bool isLoading,
    bool isEmpty,
    bool isError,
    bool isSuccess,
    String errorMessage,
    this.album,
    this.newImages,
    this.allImages,
    this.forceRefresh,
  }) : super(
          isLoading: isLoading,
          isSuccess: isSuccess,
          isEmpty: isEmpty,
          isError: isError,
          errorMessage: errorMessage,
        );

  final AlbumItemModel album;
  final List<GalleryImageModel> newImages;
  final List<BaseImageModel> allImages;
  final int forceRefresh;

  factory AddAlbumState.initial() {
    return AddAlbumState(
      isSuccess: false,
      isEmpty: false,
      isError: false,
      isLoading: false,
      errorMessage: null,
      album: null,
      newImages: List(),
      allImages: List(),
      forceRefresh: null,
    );
  }

  AddAlbumState copyWith({
    bool isLoading,
    bool isSuccess,
    bool isEmpty,
    bool isError,
    String errorMessage,
    AlbumItemModel album,
    List<GalleryImageModel> newImages,
    List<BaseImageModel> allImages,
    int forceRefresh,
  }) {
    return AddAlbumState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isEmpty: isEmpty ?? this.isEmpty,
      isError: isError ?? this.isError,
      errorMessage: errorMessage ?? this.errorMessage,
      album: album ?? this.album,
      newImages: newImages ?? this.newImages,
      allImages: allImages ?? this.allImages,
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
        album,
        newImages,
        allImages,
        forceRefresh,
      ];
}
