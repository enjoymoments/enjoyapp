part of 'add_time_line_bloc.dart';

abstract class AddTimeLineEvent extends Equatable {
  const AddTimeLineEvent();
}

class TextPost extends AddTimeLineEvent {
  final String text;

  TextPost(this.text);

  @override
  List<Object> get props => [text];
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

  SaveTimeLine();

  @override
  List<Object> get props => [];
}

class RemoveMedia extends AddTimeLineEvent {
  final GalleryImageModel media;

  RemoveMedia(this.media);

  @override
  List<Object> get props => [
        media,
      ];
}
