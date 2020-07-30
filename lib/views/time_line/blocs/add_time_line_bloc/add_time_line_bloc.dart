import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mozin/modules/shared/wrapper_media_service.dart';

part 'add_time_line_event.dart';
part 'add_time_line_state.dart';

class AddTimeLineBloc extends Bloc<AddTimeLineEvent, AddTimeLineState> {
  AddTimeLineBloc(this.wrapperMediaService) : super(AddTimeLineState.initial());

  final WrapperMediaService wrapperMediaService;

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

    List<File> files = [];

    if (event.source == ImageSource.camera) {
      var file = await wrapperMediaService.openCamera();
      files = file != null ? [file] : [];
    } else if (event.source == ImageSource.gallery) {
      files = await wrapperMediaService.getMedias();
    }

    yield state.copyWith(isLoading: false, medias: files);
  }
}
