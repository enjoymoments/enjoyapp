import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mozin/features/places/data/models/place_model.dart';
import 'package:mozin/features/places/presentation/pages/widgets/rating_item.dart';
import 'package:mozin/modules/config/router.gr.dart';
import 'package:mozin/modules/config/size_config.dart';
import 'package:mozin/package_view/custom_badge.dart';
import 'package:mozin/package_view/extension.dart';
import 'package:mozin/package_view/spacer_box.dart';

class PlaceCardItem extends StatelessWidget {
  final PlaceModel item;

  const PlaceCardItem({Key key, @required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //ExtendedNavigator.of(context).push(Routes.place_item_details);
      },
      child: Container(
        padding: const EdgeInsets.only(
          top: 20.0,
          bottom: 20.0,
          left: 5.0,
          right: 5.0,
        ),
        decoration: myBoxDecoration(context),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  item.name.title(context),
                  SpacerBox.v8,
                  Row(
                    children: [
                      CustomBadge(
                        child: RatingItem(
                          item: item,
                        ),
                      ),
                      SpacerBox.h8,
                      CustomBadge(
                        child: (item.types?.first ?? 'Sorvetes').description(
                          context,
                        ),
                      ),
                    ],
                  ),
                  SpacerBox.v8,
                  item.vicinity.description(
                    context,
                    maxLines: 2,
                  ),
                ],
              ),
            ),
            _buildIcon(),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon() {
    return CachedNetworkImage(
      fit: BoxFit.cover,
      imageUrl: item.icon,
      height: SizeConfig.sizeByPixel(25),
    );
  }

  BoxDecoration myBoxDecoration(BuildContext context) {
    return BoxDecoration(
      border: Border.all(color: Theme.of(context).hintColor),
      borderRadius: BorderRadius.all(Radius.circular(5.0)),
    );
  }
}
