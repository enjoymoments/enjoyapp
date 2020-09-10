import 'package:flutter/material.dart';
import 'package:mozin/views/places/place_item_details.dart';
import 'package:mozin/views/shared/custom_badge.dart';
import 'package:mozin/views/shared/extension.dart';
import 'package:mozin/views/shared/spacer_box.dart';

class PlaceCardItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => PlaceItemDetails(),
          ),
        );
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
                      child: _buildRating(context),
                    ),
                    SpacerBox.h8,
                    CustomBadge(
                      child: 'Sorvetes'.description(
                        context,
                        color: Theme.of(context).iconTheme.color,
                      ),
                    ),
                  ],
                ),
                SpacerBox.v8,
                "R. Doces lembranças, 123 - Vila Eternize,  São Paulo - SP, 04310-040"
                    .description(context,
                        maxLines: 2, color: Theme.of(context).iconTheme.color),
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

  Widget _buildRating(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        "4,3".description(context, color: Theme.of(context).iconTheme.color),
        SpacerBox.h5,
        Icon(
          Icons.star,
          size: 10,
        ),
        SpacerBox.h5,
        "(1.568)"
            .description(context, color: Theme.of(context).iconTheme.color),
      ],
    );
  }
}
