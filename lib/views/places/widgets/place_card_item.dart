import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mozin/router.gr.dart';
import 'package:mozin/views/places/widgets/rating_item.dart';
import 'package:mozin/views/shared/custom_badge.dart';
import 'package:mozin/views/shared/extension.dart';
import 'package:mozin/views/shared/spacer_box.dart';

class PlaceCardItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ExtendedNavigator.of(context).push(Routes.place_item_details);
      },
      child: Container(
        padding: const EdgeInsets.only(
            top: 20.0, bottom: 20.0, left: 5.0, right: 5.0),
        decoration: myBoxDecoration(context),
        child: Row(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                "Gelato".title(context),
                SpacerBox.v8,
                Row(
                  children: [
                    CustomBadge(
                      child: RatingItem(),
                    ),
                    SpacerBox.h8,
                    CustomBadge(
                      child: 'Sorvetes'.description(
                        context,
                      ),
                    ),
                  ],
                ),
                SpacerBox.v8,
                "R. Doces lembranças, 123 - Vila Eternize, \nSão Paulo - SP, 04310-040"
                    .description(
                  context,
                  maxLines: 2,
                ),
              ],
            ),
            Expanded(
              child: Image.asset(
                'assets/images/ice_cream.png',
                fit: BoxFit.fill,
              ),
            ),
          ],
        ),
      ),
    );
  }

  BoxDecoration myBoxDecoration(BuildContext context) {
    return BoxDecoration(
      border: Border.all(color: Theme.of(context).hintColor),
      borderRadius: BorderRadius.all(Radius.circular(5.0)),
    );
  }
}
