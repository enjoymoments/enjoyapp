import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mozin/features/albums/data/models/album_item_model.dart';
import 'package:mozin/features/albums/domain/repositories/albums_repository.dart';
import 'package:mozin/features/screen_manager/presentation/bloc/screen_manager_bloc.dart';
import 'package:mozin/modules/config/setup.dart';
import 'package:mozin/modules/shared/general/models/base_image_model.dart';
import 'package:mozin/modules/shared/general/models/gallery_image_model.dart';
import 'package:mozin/modules/shared/general/models/user_wrapper.dart';
import 'package:mozin/modules/shared/general/services/wrapper_media_service.dart';
import 'package:mozin/package_view/blocs/default_state.dart';
import 'package:mozin/package_view/utils.dart';

part 'edit_album_state.dart';

class EditAlbumCubit extends Cubit<EditAlbumState> {
  EditAlbumCubit({
    @required WrapperMediaService wrapperMediaService,
    @required AlbumsRepository albumsRepository,
    @required UserWrapper userWrapper,
  })  : assert(wrapperMediaService != null),
        _wrapperMediaService = wrapperMediaService,
        assert(albumsRepository != null),
        _albumsRepository = albumsRepository,
        assert(userWrapper != null),
        _userWrapper = userWrapper,
        super(EditAlbumState.initial());

  final WrapperMediaService _wrapperMediaService;
  final AlbumsRepository _albumsRepository;
  final UserWrapper _userWrapper;

  void deleteAlbum(AlbumItemModel item) async {
    var _user = _userWrapper.getUser;
    Either<bool, Exception> _response = await _albumsRepository.deleteAlbum(_user.id, item.id);

    _response.fold((success) {
      emit(state.copyWith(
        isLoading: false,
        isError: false,
        isSuccess: true,
        errorMessage: "Ops... houve um erro. Tente novamente"
      ));
    }, (error) {
      emit(state.copyWith(
        isLoading: false,
        isError: true,
        errorMessage: "Ops... houve um erro. Tente novamente",
        forceRefresh: StateUtils.generateRandomNumber(),
      ));
    });
  }

  void setAlbum(AlbumItemModel album) {
    emit(state.copyWith(album: album, allImages: album.medias));
  }

  void mapSaveToState(String titleAlbum) async {
    if (titleAlbum == null || titleAlbum.isEmpty) {
      emit(state.copyWith(
        isLoading: false,
        isError: true,
        errorMessage: "Informe um título para o álbum",
        forceRefresh: StateUtils.generateRandomNumber(),
      ));
      return;
    }

    if (state.newImages == null || state.newImages.length == 0) {
      emit(state.copyWith(
        isLoading: false,
        isError: true,
        errorMessage: "Informe ao menos uma imagem",
        forceRefresh: StateUtils.generateRandomNumber(),
      ));
      return;
    }

    getItInstance<ScreenManagerBloc>()
      ..add(QueueNewAlbum(titleAlbum, state.newImages));
    emit(state.copyWith(isLoading: false, isError: false, isSuccess: true));
  }

  void mapRemoveMediaToState(BaseImageModel media) {
    try {
      state.allImages.removeWhere((element) => element.id == media.id);

      //TODO:review this, remove the server too.
      // if (media is MediaModel) {
      //   state.album.medias.removeWhere((element) => element.id == media.id);
      // }

      if (media is GalleryImageModel) {
        state.newImages.removeWhere((element) => element.id == media.id);
      }

      emit(state.copyWith(
          isError: false,
          allImages: state.allImages,
          newImages: state.newImages,
          forceRefresh: StateUtils.generateRandomNumber()));
    } catch (e) {
      emit(state.copyWith(isError: true));
    }
  }

  void mapOpenCameraToState(ImageSource source) async {
    emit(state.copyWith(isLoading: true, isError: false));

    try {
      List<BaseImageModel> _allImages = [];
      List<GalleryImageModel> _newImages = state.newImages ?? [];

      if (state.album?.medias != null && state.album.medias.length > 0) {
        _allImages.addAll(state.album.medias);
      }

      if (state.newImages.length > 0) {
        _allImages.addAll(state.newImages);
      }

      if (source == ImageSource.camera) {
        var file = await _wrapperMediaService.openCamera();
        if (file != null) {
          var newItem = GalleryImageModel(
              id: _wrapperMediaService.generateUUIDv4(), file: file, index: 0);

          _allImages.add(newItem);
          _newImages.add(newItem);
        }
      } else if (source == ImageSource.gallery) {
        var files = await _wrapperMediaService.getMedias();
        if (files != null) {
          if ((files.length + state.allImages.length) > 10) {
            emit(state.copyWith(
                isLoading: false,
                isError: true,
                errorMessage: 'Sua postagem deve conter no máximo 10 fotos.'));
            return;
          }

          var _transform = _wrapperMediaService.transformFilesToImages(files);
          _allImages.addAll(_transform);
          _newImages.addAll(_transform);
        }
      }

      emit(
        state.copyWith(
            isLoading: false, allImages: _allImages, newImages: _newImages),
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, isError: true));
    }
  }
}
