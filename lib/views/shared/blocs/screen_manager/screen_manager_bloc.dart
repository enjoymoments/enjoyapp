import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mozin/modules/config/constants.dart';
import 'package:mozin/modules/firebase/firebase_storage_service.dart';
import 'package:mozin/modules/shared/models/gallery_image_model.dart';
import 'package:mozin/modules/shared/models/key_value.dart';
import 'package:mozin/modules/shared/models/user_app_model.dart';
import 'package:mozin/modules/time_line/models/media_model.dart';
import 'package:mozin/modules/time_line/models/time_line_model.dart';
import 'package:mozin/modules/time_line/services/time_line_service.dart';
import 'package:mozin/modules/config/setup.dart';
import 'package:mozin/views/shared/enum/default_menu_enum.dart';
import 'package:mozin/views/time_line/blocs/time_line_bloc/time_line_bloc.dart';
import 'package:path/path.dart' as Path;

part 'screen_manager_event.dart';
part 'screen_manager_state.dart';

class ScreenManagerBloc extends Bloc<ScreenManagerEvent, ScreenManagerState> {
  ScreenManagerBloc(this.firebaseStorageService, this.user, this.timeLineService)
      : super(ScreenManagerState.initial());

  final TimeLineService timeLineService;
  final FirebaseStorageService firebaseStorageService;
  final UserAppModel user;

  @override
  Stream<ScreenManagerState> mapEventToState(
    ScreenManagerEvent event,
  ) async* {
    if (event is QueueNewPost) {
      yield* mapSaveToState(event);
    } else if (event is QueueReset) {
      yield* mapQueueResetToState();
    } else if (event is TapScreen) {
      yield* mapTapScreenToState(event);
    }
  }

  Stream<ScreenManagerState> mapTapScreenToState(TapScreen event) async* {
   yield state.copyWith(currentScreen: event.screenSelected); 
  }

  Stream<ScreenManagerState> mapQueueResetToState() async* {
    yield ScreenManagerState.initial();
  }

  Stream<ScreenManagerState> mapSaveToState(QueueNewPost event) async* {
    yield state.copyWith(isLoading: true);

    try {
      final keyValues = await this._uploadMedias(event.medias);

      final transform = _transformTimeLineModel(keyValues);
      await this.timeLineService.addTimeLineItem(temp_time_line, transform);

      getItInstance<TimelineBloc>()..add(LoadPosts());

      yield state.copyWith(isLoading: false, isSuccess: true);

      this.add(QueueReset());
    } catch (e) {
      yield state.copyWith(isLoading: false, isFailure: true);
    }
  }

  Future<List<KeyValue<String, String>>> _uploadMedias(
      List<GalleryImageModel> medias) async {
    List<Future<dynamic>> _listFutures = [];
    List<KeyValue<String, String>> _listUrls = [];
    List<GalleryImageModel> _errorItems = [];

    for (var item in medias) {
      String extensionFile = Path.extension(item.file.path);

      try {
        _listFutures.add(
          firebaseStorageService
              .uploadFile(this.user.id, item.file, "${item.id}$extensionFile")
              .then((value) {
            _listUrls.add(KeyValue<String, String>(key: item.id, value: value));
          }).catchError((onError) {
            _errorItems.add(item);
          }),
        );
      } catch (e) {
        _errorItems.add(item);
      }
    }

    await Future.wait(_listFutures);

    return _listUrls;
  }

  TimeLineItemModel _transformTimeLineModel(
      List<KeyValue<String, String>> keyValues) {
    final timeLineItemModel = TimeLineItemModel(medias: []);

    for (var item in keyValues) {
      timeLineItemModel.medias
          .add(MediaModel(id: item.key, type: 1, url: item.value));
    }

    return timeLineItemModel;
  }
}
