part of 'queue_post_bloc.dart';

class QueuePostEvent extends Equatable {
  const QueuePostEvent();

  @override
  List<Object> get props => [];
}

class QueueNewPost extends QueuePostEvent {
  final List<GalleryImageModel> medias;

  QueueNewPost(this.medias);
}

class QueueReset extends QueuePostEvent {}
