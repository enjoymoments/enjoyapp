import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:mozin/features/places/data/models/place_model.dart';
import 'package:mozin/features/places/presentation/pages/widgets/tabs/general/widgets/phone_modal_fit.dart';
import 'package:custom_view/AppIcons.dart';
import 'package:custom_view/custom_border.dart';
import 'package:custom_view/custom_container.dart';
import 'package:custom_view/custom_icon.dart';
import 'package:custom_view/extensions/extension.dart';
import 'package:custom_view/spacer_box.dart';

class PhoneWidget extends StatelessWidget {
  final PlaceModel? item;

  const PhoneWidget({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showMaterialModalBottomSheet(
          context: context,
          builder: (context) => PhoneModalFit(
            phoneNumber: item!.formattedPhoneNumber,
          ),
        );
      },
      child: CustomBorder(
        child: CustomContainer(
          child: Row(
            children: [
              CustomIcon(
                icon: AppIcons.mobile_alt,
                color: Theme.of(context).primaryColor,
              ),
              SpacerBox.h8,
              Expanded(
                child: item!.formattedPhoneNumber!.label(
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
