import 'package:flutter/material.dart';
import 'package:mozin/views/shared/custom_border.dart';
import 'package:mozin/views/shared/custom_container.dart';
import 'package:mozin/views/shared/extension.dart';
import 'package:mozin/views/shared/spacer_box.dart';

class PinWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomBorder(
      child: CustomContainer(
        child: Row(
          children: [
            Icon(
              Icons.pin_drop,
              color: Theme.of(context).primaryColor,
            ),
            SpacerBox.h8,
            Expanded(
              child:
                  "R. Doces lembranças, 123 - Vila Eternize, São Paulo - SP, 04310-040"
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
