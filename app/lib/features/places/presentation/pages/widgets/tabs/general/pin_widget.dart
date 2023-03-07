import 'package:custom_view/custom_view.dart';
import 'package:flutter/material.dart';
import 'package:mozin/features/places/data/models/place_model.dart';
import 'package:mozin/features/places/presentation/pages/widgets/tabs/general/widgets/gps_modal_fit.dart';
import 'package:mozin/features/places/presentation/pages/widgets/tabs/general/widgets/gps_open/cubit/gpsopen_cubit.dart';

class PinWidget extends StatelessWidget {
  final PlaceModel? item;
  final GpsOpenCubit? gpsOpenCubit;

  const PinWidget({
    Key? key,
    required this.item,
    required this.gpsOpenCubit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
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
                child: item!.formattedAddress!.label(
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
