import 'package:dartz/dartz.dart';
import 'package:mozin/features/albums/data/datasources/albums_remote_data_source.dart';
import 'package:mozin/features/albums/data/models/album_item_model.dart';
import 'package:mozin/features/albums/domain/repositories/albums_repository.dart';
import 'package:flutter/material.dart';

class AlbumsRepositoryImpl implements AlbumsRepository {
  AlbumsRepositoryImpl({
    required this.remoteDataSource,
  });

  final AlbumsRemoteDataSource? remoteDataSource;

  @override
  Future<Either<String, Exception>> addAlbum(
      String userId, AlbumItemModel model) async {
    try {
      var response = await remoteDataSource!.addAlbum(userId, model);
      return Left<String, Exception>(response);
    } on dynamic catch (e) {
      return Right<String, Exception>(e);
    }
  }

  @override
  Future<Either<List<AlbumItemModel>, Exception>> getAlbums(
      String userId, int limit) async {
    try {
      var response = await remoteDataSource!.getAlbums(userId, limit);
      return Left<List<AlbumItemModel>, Exception>(response);
    } on dynamic catch (e) {
      return Right<List<AlbumItemModel>, Exception>(e);
    }
  }

  @override
  Future<Either<bool, Exception>> deleteAlbum(String userId, String? albumId) async {
    try {
      var response = await remoteDataSource!.deleteAlbum(userId, albumId);
      return Left<bool, Exception>(response);
    } on dynamic catch (e) {
      return Right<bool, Exception>(e);
    }
  }
}
