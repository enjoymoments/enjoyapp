import 'package:mozin/features/albums/data/datasources/albums_remote_data_source.dart';
import 'package:mozin/features/albums/domain/repositories/albums_repository.dart';
import 'package:flutter/material.dart';

class AlbumsRepositoryImpl implements AlbumsRepository {
  AlbumsRepositoryImpl({
    @required this.remoteDataSource,
  });

  final AlbumsRemoteDataSource remoteDataSource;
}
