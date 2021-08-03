import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:mozin/features/albums/data/models/album_item_model.dart';
import 'package:mozin/features/albums/domain/repositories/albums_repository.dart';
import 'package:mozin/modules/shared/general/models/user_wrapper.dart';
import 'package:mozin/modules/shared/core_migrate/bloc/default_state.dart';
import 'package:mozin_core/utils.dart';
part 'albums_state.dart';

class AlbumsCubit extends Cubit<AlbumsState> {
  AlbumsCubit({
    @required AlbumsRepository albumsRepository,
    @required UserWrapper userWrapper,
  })  : assert(userWrapper != null),
        _userWrapper = userWrapper,
        assert(albumsRepository != null),
        _albumsRepository = albumsRepository,
        super(AlbumsState.initial());

  final AlbumsRepository _albumsRepository;
  final UserWrapper _userWrapper;

  void mapGetAllAlbums() async {
    emit(state.copyWith(isLoading: true));
    
    var response =
        await _albumsRepository.getAlbums(_userWrapper.getUser.id, 10);

    response.fold((model) {
      emit(state.copyWith(
        isLoading: false,
        isError: false,
        isSuccess: true,
        albums: model,
        forceRefresh: StateUtils.generateRandomNumber(),
      ));
    }, (error) {
      emit(state.copyWith(
        isLoading: false,
        isError: true,
        isSuccess: false,
        forceRefresh: StateUtils.generateRandomNumber(),
      ));
    });
  }
}
