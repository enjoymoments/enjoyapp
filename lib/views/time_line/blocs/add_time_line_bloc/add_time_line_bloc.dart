import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mozin/modules/shared/galley_images/models/gallery_image_model.dart';
import 'package:mozin/modules/shared/wrapper_media_service.dart';
import 'package:uuid/uuid.dart';

part 'add_time_line_event.dart';
part 'add_time_line_state.dart';

class AddTimeLineBloc extends Bloc<AddTimeLineEvent, AddTimeLineState> {
  AddTimeLineBloc(this.wrapperMediaService, this.uuidService)
      : super(AddTimeLineState.initial());

  final WrapperMediaService wrapperMediaService;
  final Uuid uuidService;

  @override
  Stream<AddTimeLineState> mapEventToState(
    AddTimeLineEvent event,
  ) async* {
    if (event is OpenMediaEvent) {
      yield* mapOpenCameratoState(event);
    }
  }

  Stream<AddTimeLineState> mapOpenCameratoState(OpenMediaEvent event) async* {
    yield state.copyWith(isLoading: true);

    List<GalleryImageModel> images = [];

    if (event.source == ImageSource.camera) {
      var file = await wrapperMediaService.openCamera();
      images = file != null
          ? [
              GalleryImageModel(id: uuidService.v4(), file: file),
            ]
          : [];
    } else if (event.source == ImageSource.gallery) {
      var files = await wrapperMediaService.getMedias();
      images = _transformFilesToImages(files);
    }

    yield state.copyWith(isLoading: false, images: images);
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
