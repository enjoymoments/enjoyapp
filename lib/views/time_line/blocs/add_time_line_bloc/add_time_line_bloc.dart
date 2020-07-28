import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mozin/modules/shared/image_picker_service.dart';

part 'add_time_line_event.dart';
part 'add_time_line_state.dart';

class AddTimeLineBloc extends Bloc<AddTimeLineEvent, AddTimeLineState> {
  AddTimeLineBloc(this.imagePickerService) : super(AddTimeLineState.initial());

  final ImagePickerService imagePickerService;

  @override
  Stream<AddTimeLineState> mapEventToState(
    AddTimeLineEvent event,
  ) async* {
    if (event is OpenCameraEvent) {
      yield* mapOpenCameratoState(event);
    }
  }

  Stream<AddTimeLineState> mapOpenCameratoState(OpenCameraEvent event) async* {
    yield state.copyWith(isLoading: true);
    var result = await imagePickerService.getImageAsync(source: event.source);
    yield state.copyWith(isLoading: false, medias: [result]);
  }
}
