part of 'screen_manager_bloc.dart';

class ScreenManagerEvent extends Equatable {
  const ScreenManagerEvent();

  @override
  List<Object> get props => [];
}
class QueueNewPost extends ScreenManagerEvent {
  final String? textPost;
  final List<GalleryImageModel>? medias;

  QueueNewPost(this.textPost, this.medias);
}
class QueueNewAlbum extends ScreenManagerEvent {
  final String titleAlbum;
  final List<GalleryImageModel>? medias;

  QueueNewAlbum(this.titleAlbum, this.medias);
}
class TapScreen extends ScreenManagerEvent {
  final DefaultMenuEnum screenSelected;
  final BuildContext context;

  TapScreen(this.screenSelected, this.context);
}