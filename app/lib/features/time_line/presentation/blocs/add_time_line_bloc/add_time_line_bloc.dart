import 'dart:async';

import 'package:image_picker/image_picker.dart';
import 'package:mozin/features/screen_manager/presentation/bloc/screen_manager_bloc.dart';
import 'package:mozin/modules/shared/general/models/gallery_image_model.dart';
import 'package:mozin/modules/shared/general/services/wrapper_media_service.dart';
import 'package:mozin/modules/config/setup.dart';
import 'package:custom_utilities/custom_utilities.dart';
import 'package:rxdart/rxdart.dart';

part 'add_time_line_event.dart';
part 'add_time_line_state.dart';

class AddTimeLineBloc extends Bloc<AddTimeLineEvent, AddTimeLineState> {
  AddTimeLineBloc(
    this.wrapperMediaService,
  ) : super(AddTimeLineState.initial());

  final WrapperMediaService? wrapperMediaService;

  @override
  Stream<Transition<AddTimeLineEvent, AddTimeLineState>> transformEvents(
    Stream<AddTimeLineEvent> events,
    TransitionFunction<AddTimeLineEvent, AddTimeLineState> transitionFn,
  ) {
    final Stream<AddTimeLineEvent> nonDebounceStream =
        events.where((AddTimeLineEvent event) {
      return event is! TextPost;
    });

    final Stream<AddTimeLineEvent> debounceStream =
        events.where((AddTimeLineEvent event) {
      return event is TextPost;
    }).debounceTime(const Duration(milliseconds: 300));

    return super.transformEvents(
        nonDebounceStream.mergeWith(<Stream<AddTimeLineEvent>>[debounceStream]),
        transitionFn);
  }

  @override
  Stream<AddTimeLineState> mapEventToState(
    AddTimeLineEvent event,
  ) async* {
    if (event is OpenMediaEvent) {
      yield* mapOpenCameraToState(event);
    } else if (event is SaveTimeLine) {
      yield* mapSaveToState();
    } else if (event is RemoveMedia) {
      yield* mapRemoveMediaToState(event);
    } else if (event is TextPost) {
      yield state.copyWith(textPost: event.text);
    }
  }

  Stream<AddTimeLineState> mapRemoveMediaToState(RemoveMedia event) async* {
    try {
      state.images!.removeWhere((element) => element.id == event.media.id);

      yield state.copyWith(
          isError: false,
          images: state.images,
          forceRefresh: StateUtils.generateRandomNumber() as int?);
    } catch (e) {
      yield state.copyWith(isError: true);
    }
  }

  Stream<AddTimeLineState> mapSaveToState() async* {
    getItInstance<ScreenManagerBloc>()
      ..add(QueueNewPost(state.textPost, state.images));
    yield state.copyWith(isLoading: false, isError: false, isSuccess: true);
  }

  Stream<AddTimeLineState> mapOpenCameraToState(OpenMediaEvent event) async* {
    yield state.copyWith(isLoading: true, isError: false);

    try {
      List<GalleryImageModel> images = state.images ?? [];

      if (event.source == ImageSource.camera) {
        var file = await wrapperMediaService!.openCamera();
        if (file != null) {
          images
            ..addAll([
              GalleryImageModel(
                  id: wrapperMediaService!.generateUUIDv4(),
                  file: file,
                  index: 0)
            ]);
        }
      } else if (event.source == ImageSource.gallery) {
        var files = await wrapperMediaService!.getMedias();
        if (files != null) {
          if ((files.length + state.images!.length) > 10) {
            yield state.copyWith(
                isLoading: false,
                isError: true,
                errorMessage: 'Sua postagem deve conter no máximo 10 fotos.');
            return;
          }

          images.addAll(wrapperMediaService!.transformFilesToImages(files));
        }
      }

      yield state.copyWith(isLoading: false, images: images);
    } catch (e) {
      yield state.copyWith(isLoading: false, isError: true);
    }
  }
}
