import 'package:flutter/material.dart';
import 'package:mozin/views/shared/custom_border.dart';
import 'package:mozin/views/shared/custom_container.dart';
import 'package:mozin/views/shared/spacer_box.dart';
import 'package:mozin/views/shared/extension.dart';

class PlaceAvailableWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomBorder(
      child: CustomContainer(
        child: Row(
          children: [
            Icon(
              Icons.timer,
              color: Theme.of(context).primaryColor,
            ),
            SpacerBox.h8,
            Expanded(
              child:
                  "Aberto"
                      .label(
                context,
                color: Theme.of(context).primaryColor
              ),
            ),
          ],
        ),
      ),
    );
  }
}