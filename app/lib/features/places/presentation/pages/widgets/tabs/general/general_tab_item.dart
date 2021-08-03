import 'package:flutter/material.dart';
import 'package:mozin/features/places/data/models/place_model.dart';
import 'package:mozin/features/places/presentation/pages/widgets/tabs/general/phone_widget.dart';
import 'package:mozin/features/places/presentation/pages/widgets/tabs/general/pin_widget.dart';
import 'package:mozin/features/places/presentation/pages/widgets/tabs/general/place_available_widget.dart';
import 'package:mozin/features/places/presentation/pages/widgets/tabs/general/widgets/gps_open/cubit/gpsopen_cubit.dart';
import 'package:custom_view/spacer_box.dart';

class GeneralTabItem extends StatelessWidget {
  final PlaceModel item;
  final GpsOpenCubit gpsOpenCubit;

  const GeneralTabItem({Key key, @required this.item, @required this.gpsOpenCubit,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PinWidget(item: item, gpsOpenCubit: gpsOpenCubit,),
        SpacerBox.v8,
        PlaceAvailableWidget(item: item),
        SpacerBox.v8,
        PhoneWidget(item: item),
      ],
    );
  }
}
