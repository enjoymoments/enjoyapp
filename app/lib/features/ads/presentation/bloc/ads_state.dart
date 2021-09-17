part of 'ads_cubit.dart';

class AdsState extends DefaultState {
  AdsState({
    bool? isLoading,
    bool? isEmpty,
    bool? isError,
    bool? isSuccess,
    String? errorMessage,
    this.banners,
    this.publisherBanners,
  }) : super(
          isLoading: isLoading,
          isSuccess: isSuccess,
          isEmpty: isEmpty,
          isError: isError,
          errorMessage: errorMessage,
        );

  final List<BannerAd>? banners;
  final List<BannerAd>? publisherBanners;

  factory AdsState.initial() {
    return AdsState(
      isSuccess: false,
      isEmpty: false,
      isError: false,
      isLoading: false,
      errorMessage: null,
      banners: [],
      publisherBanners: [],
    );
  }

  AdsState copyWith({
    bool? isLoading,
    bool? isSuccess,
    bool? isEmpty,
    bool? isError,
    String? errorMessage,
    List<BannerAd>? banners,
    List<BannerAd>? publisherBanners,
  }) {
    return AdsState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isEmpty: isEmpty ?? this.isEmpty,
      isError: isError ?? this.isError,
      errorMessage: errorMessage ?? this.errorMessage,
      banners: banners ?? this.banners,
      publisherBanners: publisherBanners ?? this.publisherBanners,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        isSuccess,
        isEmpty,
        isError,
        errorMessage,
        banners,
        publisherBanners,
      ];
}
