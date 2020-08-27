import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mozin/constants.dart';
import 'package:mozin/modules/shared/models/gallery_image_model.dart';
import 'package:mozin/modules/shared/models/key_value.dart';
import 'package:mozin/modules/shared/models/user.dart';
import 'package:mozin/modules/shared/services/wrapper_media_service.dart';
import 'package:mozin/modules/time_line/models/media_model.dart';
import 'package:mozin/modules/time_line/models/time_line_model.dart';
import 'package:mozin/modules/time_line/services/time_line_service.dart';
import 'package:mozin/views/time_line/blocs/upload_image/upload_image_bloc.dart';
import 'package:uuid/uuid.dart';

part 'add_time_line_event.dart';
part 'add_time_line_state.dart';

class AddTimeLineBloc extends Bloc<AddTimeLineEvent, AddTimeLineState> {
  AddTimeLineBloc(
    this.wrapperMediaService,
    this.uuidService,
    this.user,
    this.uploadImageBloc,
    this.timeLineService,
  ) : super(AddTimeLineState.initial());

  final WrapperMediaService wrapperMediaService;
  final Uuid uuidService;
  final User user;
  final UploadImageBloc uploadImageBloc;
  final TimeLineService timeLineService;

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
      final keyValues = await this.uploadImageBloc.uploadGalleryImages(event.images);

      final transform = _transformTimeLineModel(keyValues);
      await this.timeLineService.addTimeLineItem(temp_time_line, transform);

      yield state.copyWith(isLoading: false, isSuccess: true);
    } catch (e) {
      yield state.copyWith(isLoading: false, isFailure: true);
    }
  }

  Stream<AddTimeLineState> mapOpenCameraToState(OpenMediaEvent event) async* {
    yield state.copyWith(isLoading: true);

    try {
      List<GalleryImageModel> images = state.images ?? [];

      if (event.source == ImageSource.camera) {
        var file = await wrapperMediaService.openCamera();
        if (file != null) {
          images = [
            GalleryImageModel(id: uuidService.v4(), file: file, index: 0)
          ];
        }
      } else if (event.source == ImageSource.gallery) {
        var files = await wrapperMediaService.getMedias();
        if (files != null) {
          images = _transformFilesToImages(files);
        }
      }

      yield state.copyWith(isLoading: false, images: images);
    } catch (e) {
      yield state.copyWith(isLoading: false, isFailure: true);
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

  TimeLineItemModel _transformTimeLineModel(List<KeyValue<String, String>> keyValues) {
    final timeLineItemModel = TimeLineItemModel(medias: []);

    for (var item in keyValues) {
      timeLineItemModel.medias.add(MediaModel(id:item.key, type: 1, url: item.value));
    }

    return timeLineItemModel;
  }
}
