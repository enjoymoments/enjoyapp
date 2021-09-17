part of 'albums_cubit.dart';

class AlbumsState extends DefaultState {
  AlbumsState({
    bool? isLoading,
    bool? isEmpty,
    bool? isError,
    bool? isSuccess,
    String? errorMessage,
    this.albums,
    this.forceRefresh,
  }) : super(
          isLoading: isLoading,
          isSuccess: isSuccess,
          isEmpty: isEmpty,
          isError: isError,
          errorMessage: errorMessage,
        );

  final List<AlbumItemModel>? albums;
  final int? forceRefresh;

  factory AlbumsState.initial() {
    return AlbumsState(
      isSuccess: false,
      isEmpty: false,
      isError: false,
      isLoading: false,
      errorMessage: null,
      albums: [],
      forceRefresh: null,
    );
  }

  AlbumsState copyWith({
    bool? isLoading,
    bool? isSuccess,
    bool? isEmpty,
    bool? isError,
    String? errorMessage,
    List<AlbumItemModel>? albums,
    int? forceRefresh,
  }) {
    return AlbumsState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isEmpty: isEmpty ?? this.isEmpty,
      isError: isError ?? this.isError,
      errorMessage: errorMessage ?? this.errorMessage,
      albums: albums ?? this.albums,
      forceRefresh: forceRefresh ?? this.forceRefresh,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        isSuccess,
        isEmpty,
        isError,
        errorMessage,
        albums,
        forceRefresh,
      ];
}
