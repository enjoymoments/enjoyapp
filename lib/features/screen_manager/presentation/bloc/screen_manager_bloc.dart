import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mozin/features/albums/data/models/album_item_model.dart';
import 'package:mozin/features/albums/domain/repositories/albums_repository.dart';
import 'package:mozin/features/time_line/domain/repositories/time_line_repository.dart';
import 'package:mozin/features/time_line/presentation/blocs/time_line_bloc/time_line_bloc.dart';
import 'package:mozin/modules/config/constants.dart';
import 'package:mozin/modules/config/router.gr.dart';
import 'package:mozin/modules/shared/general/models/gallery_image_model.dart';
import 'package:mozin/modules/shared/general/models/key_value.dart';
import 'package:mozin/modules/shared/general/models/media_model.dart';
import 'package:mozin/features/time_line/data/models/time_line_model.dart';
import 'package:mozin/modules/config/setup.dart';
import 'package:mozin/modules/shared/general/models/user_wrapper.dart';
import 'package:mozin/modules/shared/general/services/local_storage_service.dart';
import 'package:mozin/modules/shared/general/services/wrapper_media_service.dart';
import 'package:mozin/package_view/enum/default_menu_enum.dart';

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

  final TimelineRepository timelineRepository;
  final AlbumsRepository albumsRepository;

  final WrapperMediaService wrapperMediaService;

  final UserWrapper userWrapper;
  final LocalStorageService localStorageService;

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
    if (event.screenSelected == DEFAULT_MENU_ENUM.SEARCH) {
      if (localStorageService.containsKey(bypass_interest_filter)) {
        ExtendedNavigator.of(event.context).push(Routes.search_places_screen);
      } else {
        localStorageService.put(KeyValue<String, String>(
            key: bypass_interest_filter, value: bypass_interest_filter));
        ExtendedNavigator.of(event.context).push(Routes.interest_screen,
            arguments: InterestScreenArguments(isChangeFilter: false));
      }
    } else {
      yield state.copyWith(currentScreen: event.screenSelected);
    }
  }

  Stream<ScreenManagerState> postSave(QueueNewPost event) async* {
    TimeLineItemModel _transformTimeLineModel(
        List<KeyValue<String, String>> keyValues) {
      final timeLineItemModel = TimeLineItemModel(medias: []);

      for (var item in keyValues) {
        timeLineItemModel.medias
            .add(MediaModel(id: item.key, type: 1, url: item.value));
      }

      return timeLineItemModel;
    }

    yield state.copyWith(isLoading: true, isFailure: false, isSuccess: false);

    try {
      final keyValues = await wrapperMediaService.uploadMedias(event.medias);

      final transform = _transformTimeLineModel(keyValues);
      transform.textPost = event.textPost;

      final user = userWrapper.getUser;

      await this
          .timelineRepository
          .addTimeLineItem(user.timelineId, user.id, transform);

      getItInstance<TimelineBloc>()..add(LoadPosts());

      yield state.copyWith(isLoading: false, isSuccess: true, isFailure: false);
    } catch (e) {
      //TODO:not showing snacbar here. Not contains a 'Scaffold' in tree
      yield state.copyWith(isLoading: false, isFailure: true, isSuccess: false);
    }
  }

  Stream<ScreenManagerState> albumSave(QueueNewAlbum event) async* {
    AlbumItemModel _transformAlbumItemModel(
        List<KeyValue<String, String>> keyValues) {
      final albumItem = AlbumItemModel(medias: []);

      for (var item in keyValues) {
        albumItem.medias
            .add(MediaModel(id: item.key, type: 1, url: item.value));
      }

      return albumItem;
    }

    yield state.copyWith(isLoading: true, isFailure: false, isSuccess: false);

    try {
      final keyValues = await wrapperMediaService.uploadMedias(event.medias);

      final transform = _transformAlbumItemModel(keyValues);
      transform.titleAlbum = event.titleAlbum;

      final user = userWrapper.getUser;

      await this
          .albumsRepository
          .addAlbum(user.id, transform);

      //getItInstance<TimelineBloc>()..add(LoadPosts());

      yield state.copyWith(isLoading: false, isSuccess: true, isFailure: false);
    } catch (e) {
      //TODO:not showing snacbar here. Not contains a 'Scaffold' in tree
      yield state.copyWith(isLoading: false, isFailure: true, isSuccess: false);
    }
  }
}
