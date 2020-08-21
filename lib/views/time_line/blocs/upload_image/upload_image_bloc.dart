import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mozin/modules/firebase/firebase_storage_service.dart';
import 'package:mozin/modules/shared/models/gallery_image_model.dart';
import 'package:mozin/modules/shared/models/user.dart';

part 'upload_image_event.dart';
part 'upload_image_state.dart';

class UploadImageBloc extends Bloc<UploadImageEvent, UploadImageState> {
  UploadImageBloc(
    this.firebaseStorageService,
    this.user,
  ) : super(UploadImageInitial());

  final FirebaseStorageService firebaseStorageService;
  final User user;

  @override
  Stream<UploadImageState> mapEventToState(
    UploadImageEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }

  Future<List<String>> uploadGalleryImages(
      List<GalleryImageModel> images) async {
    List<Future<dynamic>> _listFutures = [];
    List<String> _listUrls = [];

    for (var image in images) {
      _listFutures.add(
        firebaseStorageService.uploadFile(this.user.id, image.file).then(
              (value) => _listUrls.add(value),
            ),
      );
    }

    await Future.wait(_listFutures);

    return _listUrls;
  }
}
