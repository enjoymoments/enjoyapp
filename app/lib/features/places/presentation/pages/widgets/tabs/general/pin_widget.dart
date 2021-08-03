import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:mozin/features/places/data/models/place_model.dart';
import 'package:mozin/features/places/presentation/pages/widgets/tabs/general/widgets/gps_modal_fit.dart';
import 'package:mozin/features/places/presentation/pages/widgets/tabs/general/widgets/gps_open/cubit/gpsopen_cubit.dart';
import 'package:custom_view/AppIcons.dart';
import 'package:custom_view/custom_border.dart';
import 'package:custom_view/custom_container.dart';
import 'package:custom_view/custom_icon.dart';
import 'package:custom_view/extensions/extension.dart';
import 'package:custom_view/spacer_box.dart';

class PinWidget extends StatelessWidget {
  final PlaceModel item;
  final GpsOpenCubit gpsOpenCubit;

  const PinWidget({Key key, @required this.item, @required this.gpsOpenCubit,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showMaterialModalBottomSheet(
          context: context,
          builder: (context) => GpsModalFit(
            gpsOpenCubit: gpsOpenCubit,
          ),
        );
      },
      child: CustomBorder(
        child: CustomContainer(
          child: Row(
            children: [
              CustomIcon(
                icon: AppIcons.map_pin,
                color: Theme.of(context).primaryColor,
              ),
              SpacerBox.h8,
              Expanded(
                child: item.formattedAddress.label(
                  context,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
