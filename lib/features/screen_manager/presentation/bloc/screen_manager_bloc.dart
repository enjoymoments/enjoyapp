import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mozin/features/albums/data/models/album_item_model.dart';
import 'package:mozin/features/albums/domain/repositories/albums_repository.dart';
import 'package:mozin/features/home/presentation/pages/home_screen.dart';
import 'package:mozin/features/me/presentation/pages/me_screen.dart';
import 'package:mozin/features/notifications/presentation/pages/notifications_screen.dart';
import 'package:mozin/features/time_line/domain/repositories/time_line_repository.dart';
import 'package:mozin/features/time_line/presentation/blocs/time_line_bloc/time_line_bloc.dart';
import 'package:mozin/features/time_line/presentation/pages/time_line_screen.dart';
import 'package:mozin/modules/config/constants.dart';
import 'package:mozin/modules/config/router.gr.dart';
import 'package:mozin/modules/shared/firebase/firebase_instance_provider.dart';
import 'package:mozin/modules/shared/general/enums.dart';
import 'package:mozin/modules/shared/general/models/gallery_image_model.dart';
import 'package:mozin/modules/shared/general/models/key_value.dart';
import 'package:mozin/modules/shared/general/models/media_model.dart';
import 'package:mozin/features/time_line/data/models/time_line_model.dart';
import 'package:mozin/modules/config/setup.dart';
import 'package:mozin/modules/shared/general/models/user_wrapper.dart';
import 'package:mozin/modules/shared/general/services/local_storage_service.dart';
import 'package:mozin/modules/shared/general/services/wrapper_media_service.dart';

part 'screen_manager_event.dart';
part 'screen_manager_state.dart';

class ScreenManagerBloc extends Bloc<ScreenManagerEvent, ScreenManagerState> {
  ScreenManagerBloc(
    this.timelineRepository,
    this.albumsRepository,
    this.wrapperMediaService,
    this.userWrapper,
    this.localStorageService,
  ) : super(ScreenManagerState.initial()) {
    _subscribeActionListener();
  }

  final TimelineRepository timelineRepository;
  final AlbumsRepository albumsRepository;

  final WrapperMediaService wrapperMediaService;

  final UserWrapper userWrapper;
  final LocalStorageService localStorageService;

  StreamSubscription<DocumentSnapshot> _actionSubscription;

  @override
  Future<void> close() {
    _unsubscribeActionListener();
    return super.close();
  }

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
    //TOOD:in test
    // else if (event is SubscribeActionListener) {
    //   _subscribeActionListener();
    // } else if (event is UnsubscribeActionListener) {
    //   _unsubscribeActionListener();
    // } else if (event is ActionListener) {
    //   var _test = event.action.data();
    //   print('test');
    // }
  }

  Stream<ScreenManagerState> mapTapScreenToState(TapScreen event) async* {
    if (event.screenSelected == DefaultMenuEnum.Search) {
      if (localStorageService.containsKey(bypass_interest_filter)) {
        ExtendedNavigator.of(event.context).push(Routes.search_places_screen);
      } else {
        localStorageService.put(KeyValue<String, String>(
            key: bypass_interest_filter, value: bypass_interest_filter));
        ExtendedNavigator.of(event.context).push(Routes.interest_screen,
            arguments: InterestScreenArguments(isChangeFilter: false));
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
          .addTimeLineItem(user.timelineSelected.id, user.id, transform);

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

      await this.albumsRepository.addAlbum(user.id, transform);

      //TODO:album
      //getItInstance<TimelineBloc>()..add(LoadPosts());

      yield state.copyWith(isLoading: false, isSuccess: true, isFailure: false);
    } catch (e) {
      //TODO:not showing snacbar here. Not contains a 'Scaffold' in tree
      yield state.copyWith(isLoading: false, isFailure: true, isSuccess: false);
    }
  }

  void _instanceScreens(
      Map<DefaultMenuEnum, Widget> contents, TapScreen event) {
    if (state.contents[event.screenSelected] == null) {
      switch (event.screenSelected) {
        case DefaultMenuEnum.TimeLine:
          contents[DefaultMenuEnum.TimeLine] = TimeLineScreen();
          break;
        case DefaultMenuEnum.Me:
          contents[DefaultMenuEnum.Me] = MeScreen();
          break;
        case DefaultMenuEnum.Alert:
          contents[DefaultMenuEnum.Alert] = NotificationsScreen();
          break;
        case DefaultMenuEnum.Home:
        default:
          contents[DefaultMenuEnum.Home] = HomeScreen();
          break;
      }
    }
  }

  void _subscribeActionListener() {
    var _instance = new FirestoreInstanceProvider();
    var _user = userWrapper.getUser;

    if (userWrapper.authenticated && _actionSubscription == null) {
      _actionSubscription = _instance.firestore
          .doc('actionListener/${_user.id}')
          .snapshots()
          .listen(
            (action) => add(ActionListener(action)),
          );
    }
  }

  void _unsubscribeActionListener() {
    _actionSubscription?.cancel();
  }
}
