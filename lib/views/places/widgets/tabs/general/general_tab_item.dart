import 'package:flutter/material.dart';
import 'package:mozin/views/places/widgets/tabs/general/phone_widget.dart';
import 'package:mozin/views/places/widgets/tabs/general/pin_widget.dart';
import 'package:mozin/views/places/widgets/tabs/general/place_available_widget.dart';
import 'package:mozin/views/shared/spacer_box.dart';

class GeneralTabItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PinWidget(),
        SpacerBox.v8,
        PlaceAvailableWidget(),
        SpacerBox.v8,
        PhoneWidget(),
      ],
    );
  }
}
