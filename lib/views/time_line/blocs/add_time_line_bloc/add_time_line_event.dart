part of 'add_time_line_bloc.dart';

abstract class AddTimeLineEvent extends Equatable {
  const AddTimeLineEvent();
}

class OpenMediaEvent extends AddTimeLineEvent {
  final ImageSource source;

  OpenMediaEvent(this.source);

  @override
  List<Object> get props => [
        source,
      ];
}

class SaveTimeLine extends AddTimeLineEvent {
  final List<GalleryImageModel> images;

  SaveTimeLine(this.images);

  @override
  List<Object> get props => [
        images,
      ];
}

class RemoveMedia extends AddTimeLineEvent {
  final GalleryImageModel media;

  RemoveMedia(this.media);

  @override
  List<Object> get props => [
        media,
      ];
}
