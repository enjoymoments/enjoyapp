import 'package:flutter/material.dart';
import 'package:mozin/views/places/widgets/place_card_item.dart';
import 'package:mozin/views/shared/custom_container.dart';

class PlacesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: PlaceCardItem(),
    );
  }
}
