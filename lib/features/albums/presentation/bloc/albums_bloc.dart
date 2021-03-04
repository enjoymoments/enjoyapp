import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:mozin/features/albums/domain/repositories/albums_repository.dart';
import 'package:mozin/package_view/blocs/default_state.dart';
part 'albums_state.dart';

class AlbumsCubit extends Cubit<AlbumsState> {
  AlbumsCubit({@required AlbumsRepository albumsRepository})
      : assert(albumsRepository != null),
        _albumsRepository = albumsRepository,
        super(AlbumsState.initial());

  final AlbumsRepository _albumsRepository;
}
