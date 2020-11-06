import 'package:flutter/material.dart';
import 'package:mozin/features/places/data/models/place_model.dart';
import 'package:mozin/features/places/presentation/pages/widgets/rating_item.dart';
import 'package:mozin/package_view/custom_border.dart';
import 'package:mozin/package_view/custom_container.dart';
import 'package:mozin/package_view/extension.dart';
import 'package:mozin/package_view/spacer_box.dart';

class UserCommentWidget extends StatelessWidget {
  final PlaceModel item;

  const UserCommentWidget({Key key, @required this.item}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return CustomBorder(
      child: CustomContainer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            "Felipe Augusto".description(context),
            SpacerBox.v8,
            Row(
              children: [
                RatingItem(item: item,),
                SpacerBox.h8,
                "Uma semana atrás".description(context, fontSize: 10),
              ],
            ),
            SpacerBox.v8,
            "Local super aconchegante, linda decoração, atendentes muito prestativas, um sorvete diferenciado. Lembrando, o Açaí é muito bom. E o preço foi justo. Adorei e recomendo."
                .label(
              context,
              maxLines: 3,
            ),
          ],
        ),
      ),
    );
  }
}
