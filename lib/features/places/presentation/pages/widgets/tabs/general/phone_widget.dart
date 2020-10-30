import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:mozin/features/places/presentation/pages/widgets/tabs/general/widgets/phone_modal_fit.dart';
import 'package:mozin/package_view/AppIcons.dart';
import 'package:mozin/package_view/custom_border.dart';
import 'package:mozin/package_view/custom_container.dart';
import 'package:mozin/package_view/custom_icon.dart';
import 'package:mozin/package_view/extension.dart';
import 'package:mozin/package_view/spacer_box.dart';

class PhoneWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showMaterialModalBottomSheet(
          context: context,
          builder: (context, scrollController) => PhoneModalFit(
            phoneNumber: "2456-8900",
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
                child: "2456-8900".label(
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
