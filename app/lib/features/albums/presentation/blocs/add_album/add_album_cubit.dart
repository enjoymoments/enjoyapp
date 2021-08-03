import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mozin/features/screen_manager/presentation/bloc/screen_manager_bloc.dart';
import 'package:mozin/modules/config/setup.dart';
import 'package:mozin/modules/shared/general/models/base_image_model.dart';
import 'package:mozin/modules/shared/general/models/gallery_image_model.dart';
import 'package:mozin/modules/shared/general/services/wrapper_media_service.dart';
import 'package:mozin/modules/shared/core_migrate/bloc/default_state.dart';
import 'package:mozin/modules/config/utils.dart';

part 'add_album_state.dart';

class AddAlbumCubit extends Cubit<AddAlbumState> {
  AddAlbumCubit({
    @required WrapperMediaService wrapperMediaService,
  })  : assert(wrapperMediaService != null),
        _wrapperMediaService = wrapperMediaService,
        super(AddAlbumState.initial());

  final WrapperMediaService _wrapperMediaService;

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

    if (state.allImages == null || state.allImages.length == 0) {
      emit(state.copyWith(
        isLoading: false,
        isError: true,
        errorMessage: "Informe ao menos uma imagem",
        forceRefresh: StateUtils.generateRandomNumber(),
      ));
      return;
    }

    getItInstance<ScreenManagerBloc>()
      ..add(QueueNewAlbum(titleAlbum, state.allImages));
    emit(state.copyWith(isLoading: false, isError: false, isSuccess: true));
  }

  void mapRemoveMediaToState(BaseImageModel media) {
    try {
      state.allImages.removeWhere((element) => element.id == media.id);
      emit(state.copyWith(
          isError: false,
          allImages: state.allImages,
          forceRefresh: StateUtils.generateRandomNumber()));
    } catch (e) {
      emit(state.copyWith(isError: true));
    }
  }

  void mapOpenCameraToState(ImageSource source) async {
    emit(state.copyWith(isLoading: true, isError: false));

    try {
      List<GalleryImageModel> _allImages = [];

      if (state.allImages.length > 0) {
        _allImages.addAll(state.allImages);
      }

      if (source == ImageSource.camera) {
        var file = await _wrapperMediaService.openCamera();
        if (file != null) {
          var newItem = GalleryImageModel(
              id: _wrapperMediaService.generateUUIDv4(), file: file, index: 0);

          _allImages.add(newItem);
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
        }
      }

      emit(
        state.copyWith(isLoading: false, allImages: _allImages),
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, isError: true));
    }
  }
}
