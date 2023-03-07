import 'package:custom_view/custom_view.dart';
import 'package:flutter/material.dart';
import 'package:mozin/features/places/data/models/place_model.dart';
import 'package:mozin/features/places/presentation/pages/widgets/tabs/general/widgets/phone_modal_fit.dart';

class PhoneWidget extends StatelessWidget {
  final PlaceModel? item;

  const PhoneWidget({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
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
