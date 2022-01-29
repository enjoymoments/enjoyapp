import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:mozin/features/albums/data/models/album_item_model.dart';
import 'package:mozin/features/albums/domain/repositories/albums_repository.dart';
import 'package:mozin/features/calendar/presentation/pages/calendar_content.dart';
import 'package:mozin/features/me/presentation/pages/me_screen.dart';
import 'package:mozin/features/time_line/domain/repositories/time_line_repository.dart';
import 'package:mozin/modules/config/router.gr.dart';
import 'package:mozin/modules/shared/general/enums.dart';
import 'package:mozin/modules/shared/general/models/gallery_image_model.dart';
import 'package:custom_utilities/custom_utilities.dart';
import 'package:mozin/modules/shared/general/models/media_model.dart';
import 'package:mozin/features/time_line/data/models/time_line_model.dart';
import 'package:mozin/modules/shared/general/models/user_wrapper.dart';
import 'package:mozin/modules/shared/general/services/local_storage_service.dart';
import 'package:mozin/modules/shared/general/services/wrapper_media_service.dart';
import 'package:mozin_core/constants.dart';

part 'screen_manager_event.dart';
part 'screen_manager_state.dart';

class ScreenManagerBloc extends Bloc<ScreenManagerEvent, ScreenManagerState> {
  ScreenManagerBloc(
    this.timelineRepository,
    this.albumsRepository,
    this.wrapperMediaService,
    this.userWrapper,
    this.localStorageService,
  ) : super(ScreenManagerState.initial());

  final TimelineRepository? timelineRepository;
  final AlbumsRepository? albumsRepository;

  final WrapperMediaService? wrapperMediaService;

  final UserWrapper? userWrapper;
  final LocalStorageService? localStorageService;

  @override
  Stream<ScreenManagerState> mapEventToState(
    ScreenManagerEvent event,
  ) async* {
    if (event is QueueNewPost) {
      yield* postSave(event);
    } else if (event is QueueNewAlbum) {
      yield* albumSave(event);
    } else if (event is TapScreen) {
      yield* mapTapScreenToState(event);
    }
  }

  Stream<ScreenManagerState> mapTapScreenToState(TapScreen event) async* {
    if (event.screenSelected == DefaultMenuEnum.Search) {
      if (localStorageService!.containsKey(bypass_interest_filter)) {
        AutoRouter.of(event.context).push(Search_places_screen());
      } else {
        localStorageService!.put(KeyValue<String, String>(
            key: bypass_interest_filter, value: bypass_interest_filter));
        AutoRouter.of(event.context)
            .push(Interest_screen(isChangeFilter: false));
      }
    } else {
      var _contents = state.contents;
      _instanceScreens(_contents, event);

      yield state.copyWith(
          currentScreen: event.screenSelected, contents: _contents);
    }
  }

  Stream<ScreenManagerState> postSave(QueueNewPost event) async* {
    TimeLineItemModel _transformTimeLineModel(
        List<KeyValue<String?, String>> keyValues) {
      final timeLineItemModel = TimeLineItemModel(medias: []);

      for (var item in keyValues) {
        timeLineItemModel.medias!
            .add(MediaModel(id: item.key, type: 1, url: item.value));
      }

      return timeLineItemModel;
    }

    yield state.copyWith(isLoading: true, isFailure: false, isSuccess: false);

    try {
      final keyValues = await wrapperMediaService!.uploadMedias(event.medias!);

      final transform = _transformTimeLineModel(keyValues);
      transform.textPost = event.textPost;

      final user = userWrapper!.getUser!;

      await this
          .timelineRepository!
          .addTimeLineItem(user.timelineSelected!.id, user.id, transform);

      yield state.copyWith(isLoading: false, isSuccess: true, isFailure: false);
    } catch (e) {
      //TODO:not showing snacbar here. Not contains a 'Scaffold' in tree
      yield state.copyWith(isLoading: false, isFailure: true, isSuccess: false);
    }
  }

  Stream<ScreenManagerState> albumSave(QueueNewAlbum event) async* {
    AlbumItemModel _transformAlbumItemModel(
        List<KeyValue<String?, String>> keyValues) {
      final albumItem = AlbumItemModel(medias: []);

      for (var item in keyValues) {
        albumItem.medias!
            .add(MediaModel(id: item.key, type: 1, url: item.value));
      }

      return albumItem;
    }

    yield state.copyWith(isLoading: true, isFailure: false, isSuccess: false);

    try {
      final keyValues = await wrapperMediaService!.uploadMedias(event.medias!);

      final transform = _transformAlbumItemModel(keyValues);
      transform.titleAlbum = event.titleAlbum;

      final user = userWrapper!.getUser!;

      await this.albumsRepository!.addAlbum(user.id, transform);

      //TODO:album
      //getItInstance<TimelineBloc>()..add(LoadPosts());

      yield state.copyWith(isLoading: false, isSuccess: true, isFailure: false);
    } catch (e) {
      //TODO:not showing snacbar here. Not contains a 'Scaffold' in tree
      yield state.copyWith(isLoading: false, isFailure: true, isSuccess: false);
    }
  }

  void _instanceScreens(
      Map<DefaultMenuEnum, Widget>? contents, TapScreen event) {
    if (state.contents![event.screenSelected] == null) {
      switch (event.screenSelected) {
        //TODO:review this - temporarily
        // case DefaultMenuEnum.TimeLine:
        //   contents![DefaultMenuEnum.TimeLine] = TimeLineScreen();
        //   break;
        case DefaultMenuEnum.Me:
          contents![DefaultMenuEnum.Me] = MeScreen();
          break;
        //TODO:review this - temporarily
        // case DefaultMenuEnum.Favorites:
        //   contents![DefaultMenuEnum.Favorites] = FavoriteInterestsScreen();
        //   break;
        case DefaultMenuEnum.Calendar:
        default:
          contents![DefaultMenuEnum.Calendar] = CalendarContent();
          break;
      }
    }
  }
}
