part of 'upload_image_bloc.dart';

abstract class UploadImageState extends Equatable {
  const UploadImageState();
  
  @override
  List<Object> get props => [];
}

class UploadImageInitial extends UploadImageState {}
