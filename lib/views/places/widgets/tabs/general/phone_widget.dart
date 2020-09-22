import 'package:flutter/material.dart';
import 'package:mozin/views/shared/custom_border.dart';
import 'package:mozin/views/shared/custom_container.dart';
import 'package:mozin/views/shared/extension.dart';
import 'package:mozin/views/shared/spacer_box.dart';

class PhoneWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomBorder(
      child: CustomContainer(
        child: Row(
          children: [
            Icon(
              Icons.phone_android,
              color: Theme.of(context).primaryColor,
            ),
            SpacerBox.h8,
            Expanded(
              child:
                  "2456-8900"
                      .label(
                context,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
