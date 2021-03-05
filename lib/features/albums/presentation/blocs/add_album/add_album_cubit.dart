import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mozin/features/albums/domain/repositories/albums_repository.dart';
import 'package:mozin/modules/shared/general/models/gallery_image_model.dart';
import 'package:mozin/modules/shared/general/services/wrapper_media_service.dart';
import 'package:mozin/package_view/blocs/default_state.dart';

part 'add_album_state.dart';

class AddAlbumCubit extends Cubit<AddAlbumState> {
  AddAlbumCubit({
    @required AlbumsRepository albumsRepository,
    @required WrapperMediaService wrapperMediaService,
  })  : assert(albumsRepository != null),
        _albumsRepository = albumsRepository,
        assert(wrapperMediaService != null),
        _wrapperMediaService = wrapperMediaService,
        super(AddAlbumState.initial());

  final AlbumsRepository _albumsRepository;
  final WrapperMediaService _wrapperMediaService;

  void mapOpenCameraToState(ImageSource source) async {
    emit(state.copyWith(isLoading: true, isError: false));

    try {
      List<GalleryImageModel> images = state.images ?? [];

      if (source == ImageSource.camera) {
        var file = await _wrapperMediaService.openCamera();
        if (file != null) {
          images
            ..addAll([
              GalleryImageModel(
                  id: _wrapperMediaService.generateUUIDv4(),
                  file: file,
                  index: 0)
            ]);
        }
      } else if (source == ImageSource.gallery) {
        var files = await _wrapperMediaService.getMedias();
        if (files != null) {
          if ((files.length + state.images.length) > 10) {
            emit(state.copyWith(
                isLoading: false,
                isError: true,
                errorMessage: 'Sua postagem deve conter no máximo 10 fotos.'));
            return;
          }

          images.addAll(_wrapperMediaService.transformFilesToImages(files));
        }
      }

      emit(state.copyWith(isLoading: false, images: images));
    } catch (e) {
      emit(state.copyWith(isLoading: false, isError: true));
    }
  }
}
