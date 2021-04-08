import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mozin/features/places/presentation/blocs/place_photos/place_photos_bloc.dart';
import 'package:mozin/features/places/presentation/pages/widgets/load_photos_in_memory.dart';
import 'package:mozin/modules/config/size_config.dart';
import 'package:mozin/package_view/shimmerLoading.dart';

class PhotosTabItem extends StatelessWidget {
  final PlacePhotosBloc placePhotosBloc;

  const PhotosTabItem({Key key, @required this.placePhotosBloc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlacePhotosBloc, PlacePhotosState>(
      cubit: placePhotosBloc,
      builder: (context, state) {
        if (state.item?.photos != null) {
          return _buildPhotos(context, state.item.photos);
        }

        return _buildLoadingPhotos();
      },
    );
  }

  Widget _buildPhotos(BuildContext context, List<Uint8List> photos) {
    return Container(
      alignment: Alignment.center,
      child: Wrap(
        spacing: SizeConfig.sizeByPixel(10),
        children: buildPhotos(context, photos, SizeConfig.sizeByPixel(150)),
      ),
    );
  }

  Widget _buildLoadingPhotos() {
    return Container(
      alignment: Alignment.center,
      child: Wrap(
        spacing: SizeConfig.sizeByPixel(10),
        children: [0, 1, 2, 3]
            .map(
              (item) => Container(
                child: Container(
                  margin: EdgeInsets.all(5.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    child: ShimmerLoading(
                      width: SizeConfig.sizeByPixel(150),
                      height: SizeConfig.sizeByPixel(80),
                    ),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}