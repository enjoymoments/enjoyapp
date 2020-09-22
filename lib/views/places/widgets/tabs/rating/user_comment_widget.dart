import 'package:flutter/material.dart';
import 'package:mozin/views/places/widgets/rating_item.dart';
import 'package:mozin/views/shared/custom_border.dart';
import 'package:mozin/views/shared/custom_container.dart';
import 'package:mozin/views/shared/extension.dart';
import 'package:mozin/views/shared/spacer_box.dart';

class UserCommentWidget extends StatelessWidget {
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
                RatingItem(),
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
