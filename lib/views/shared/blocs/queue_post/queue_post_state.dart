part of 'queue_post_bloc.dart';

class QueuePostState extends Equatable {
  
  final bool isLoading;
  final List<GalleryImageModel> medias;
  final bool isSuccess;
  final bool isFailure;

  QueuePostState({
    this.isLoading,
    this.medias,
    this.isSuccess,
    this.isFailure,
  });

  factory QueuePostState.initial() {
    return QueuePostState(
      isLoading: false,
      medias: List(),
      isSuccess: false,
      isFailure: false,
    );
  }

  QueuePostState copyWith({
    bool isLoading,
    bool isSuccess,
    bool isFailure,
    List<GalleryImageModel> medias,
  }) {
    return QueuePostState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
      medias: medias ?? this.medias,
    );
  }

  @override
  List<Object> get props => [
        isLoading,
        isSuccess,
        isFailure,
        medias,
      ];
}
