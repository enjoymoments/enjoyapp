import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mozin/modules/firebase/firebase_storage_service.dart';
import 'package:mozin/modules/shared/models/gallery_image_model.dart';
import 'package:mozin/modules/shared/services/wrapper_media_service.dart';
import 'package:uuid/uuid.dart';

part 'add_time_line_event.dart';
part 'add_time_line_state.dart';

class AddTimeLineBloc extends Bloc<AddTimeLineEvent, AddTimeLineState> {
  AddTimeLineBloc(
      this.wrapperMediaService, this.uuidService, this.firebaseStorageService)
      : super(AddTimeLineState.initial());

  final WrapperMediaService wrapperMediaService;
  final FirebaseStorageService firebaseStorageService;
  final Uuid uuidService;

  @override
  Stream<AddTimeLineState> mapEventToState(
    AddTimeLineEvent event,
  ) async* {
    if (event is OpenMediaEvent) {
      yield* mapOpenCameraToState(event);
    } else if (event is SaveTimeLine) {
      yield* mapSaveToState(event);
    }
  }

  Stream<AddTimeLineState> mapSaveToState(SaveTimeLine event) async* {
    yield state.copyWith(isLoading: true);

    try {
      _updateImages(event.images);
      yield state.copyWith(isLoading: false, isSuccess: true);
    } catch (e) {
      yield state.copyWith(isLoading: false, isFailure: true);
    }
  }

  Stream<AddTimeLineState> mapOpenCameraToState(OpenMediaEvent event) async* {
    yield state.copyWith(isLoading: true);

    List<GalleryImageModel> images = state.images ?? [];

    if (event.source == ImageSource.camera) {
      var file = await wrapperMediaService.openCamera();
      images = file != null
          ? [
              GalleryImageModel(id: uuidService.v4(), file: file, index: 0),
            ]
          : [];
    } else if (event.source == ImageSource.gallery) {
      var files = await wrapperMediaService.getMedias();
      if (files != null) {
        images = _transformFilesToImages(files);
      }
    }

    yield state.copyWith(isLoading: false, images: images);
  }

  void _updateImages(List<GalleryImageModel> images) {
    firebaseStorageService.uploadFile('userIdentifier', images[0].file);
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
