part of 'screen_manager_bloc.dart';

class ScreenManagerEvent extends Equatable {
  const ScreenManagerEvent();

  @override
  List<Object> get props => [];
}

class QueueNewPost extends ScreenManagerEvent {
  final List<GalleryImageModel> medias;

  QueueNewPost(this.medias);
}

class QueueReset extends ScreenManagerEvent {}

class TapScreen extends ScreenManagerEvent {
  final DEFAULT_MENU_ENUM screenSelected;

  TapScreen(this.screenSelected);
}