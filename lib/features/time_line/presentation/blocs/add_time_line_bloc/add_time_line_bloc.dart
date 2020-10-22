import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mozin/features/screen_manager/presentation/bloc/screen_manager_bloc.dart';
import 'package:mozin/modules/shared/general/models/gallery_image_model.dart';
import 'package:mozin/modules/shared/general/services/wrapper_media_service.dart';
import 'package:mozin/modules/config/setup.dart';
import 'package:mozin/package_view/blocs/default_state.dart';
import 'package:mozin/package_view/utils.dart';
import 'package:uuid/uuid.dart';

part 'add_time_line_event.dart';
part 'add_time_line_state.dart';

class AddTimeLineBloc extends Bloc<AddTimeLineEvent, AddTimeLineState> {
  AddTimeLineBloc(
    this.wrapperMediaService,
    this.uuidService,
  ) : super(AddTimeLineState.initial());

  final WrapperMediaService wrapperMediaService;
  final Uuid uuidService;

  @override
  Stream<AddTimeLineState> mapEventToState(
    AddTimeLineEvent event,
  ) async* {
    if (event is OpenMediaEvent) {
      yield* mapOpenCameraToState(event);
    } else if (event is SaveTimeLine) {
      yield* mapSaveToState(event);
    } else if (event is RemoveMedia) {
      yield* mapRemoveMediaToState(event);
    }
  }

  Stream<AddTimeLineState> mapRemoveMediaToState(RemoveMedia event) async* {
    try {
      state.images.removeWhere((element) => element.id == event.media.id);

      yield state.copyWith(
          images: state.images,
          forceRefresh: StateUtils.generateRandomNumber());
    } catch (e) {
      yield state.copyWith(isError: true);
    }
  }

  Stream<AddTimeLineState> mapSaveToState(SaveTimeLine event) async* {
    getItInstance<ScreenManagerBloc>()..add(QueueNewPost(event.images));
    yield state.copyWith(isLoading: false, isSuccess: true);
  }

  Stream<AddTimeLineState> mapOpenCameraToState(OpenMediaEvent event) async* {
    yield state.copyWith(isLoading: true);

    try {
      List<GalleryImageModel> images = state.images ?? [];

      if (event.source == ImageSource.camera) {
        var file = await wrapperMediaService.openCamera();
        if (file != null) {
          images
            ..addAll([
              GalleryImageModel(id: uuidService.v4(), file: file, index: 0)
            ]);
        }
      } else if (event.source == ImageSource.gallery) {
        var files = await wrapperMediaService.getMedias();
        if (files != null) {
          images.addAll(_transformFilesToImages(files));
        }
      }

      yield state.copyWith(isLoading: false, images: images);
    } catch (e) {
      yield state.copyWith(isLoading: false, isError: true);
    }
  }

  List<GalleryImageModel> _transformFilesToImages(List<File> files) {
    final List<GalleryImageModel> galleryItems = [];

    for (var i = 0; i < files.length; i++) {
      var item = files[i];
      galleryItems.add(GalleryImageModel(
        id: uuidService.v4(),
        index: i,
        file: item,
      ));
    }

    return galleryItems;
  }
}