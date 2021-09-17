import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:custom_view/AppIcons.dart';
import 'package:custom_view/custom_icon.dart';
import 'package:custom_view/extensions/extension.dart';

part 'gpsopen_state.dart';

class GpsOpenCubit extends Cubit<GpsOpenState> {
  GpsOpenCubit() : super(GpsOpenInitial());

  void getElements(
      BuildContext context, String? title, String? description, double? latitude, double? longitude) async {
    List<Widget> _elements = <Widget>[];

    if (await (MapLauncher.isMapAvailable(MapType.google) as FutureOr<bool>)) {
      _elements.add(
        ListTile(
          title: 'Google Maps'.label(context),
          leading: CustomIcon(
            icon: AppIcons.map_signs,
          ),
          onTap: () async {
            await MapLauncher.showMarker(
              mapType: MapType.google,
              coords: Coords(latitude!, longitude!),
              title: title!,
              description: description,
            );
          },
        ),
      );
    }

    if (await (MapLauncher.isMapAvailable(MapType.waze) as FutureOr<bool>)) {
      _elements.add(
        ListTile(
          title: "Waze".label(context),
          leading: CustomIcon(
            icon: AppIcons.waze,
          ),
          onTap: () async {
            await MapLauncher.showMarker(
              mapType: MapType.waze,
              coords: Coords(latitude!, longitude!),
              title: title!,
              description: description,
            );
          },
        ),
      );
    }

    if (await (MapLauncher.isMapAvailable(MapType.apple) as FutureOr<bool>)) {
      _elements.add(
        ListTile(
          title: "Apple Maps".label(context),
          leading: CustomIcon(
            icon: AppIcons.apple,
          ),
          onTap: () async {
            await MapLauncher.showMarker(
              mapType: MapType.apple,
              coords: Coords(latitude!, longitude!),
              title: title!,
              description: description,
            );
          },
        ),
      );
    }

    emit(
      GpsElements(
        Column(
          mainAxisSize: MainAxisSize.min,
          children: _elements,
        ),
      ),
    );
  }
}
