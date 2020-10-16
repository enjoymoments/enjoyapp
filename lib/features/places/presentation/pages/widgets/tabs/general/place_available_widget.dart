import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:mozin/package_view/custom_border.dart';
import 'package:mozin/package_view/custom_container.dart';
import 'package:mozin/package_view/spacer_box.dart';
import 'package:mozin/package_view/extension.dart';

class PlaceAvailableWidget extends StatelessWidget {
  final ExpandableController controller = ExpandableController();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        controller.toggle();
      },
      child: CustomBorder(
        child: CustomContainer(
          child: ExpandablePanel(
            controller: controller,
            header: _buildCollapsed(context),
            expanded: _buildExpanded(context),
          ),
        ),
      ),
    );
  }

  Widget _buildCollapsed(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.timer,
          color: Theme.of(context).primaryColor,
        ),
        SpacerBox.h8,
        "Aberto".label(context, color: Theme.of(context).primaryColor),
        SpacerBox.h8,
        "Fecha às 22:30".label(context),
      ],
    );
  }

  Widget _buildExpanded(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        'Horário'.title(context),
        SpacerBox.h16,
        Column(
          children: [
            ..._buildWeek(context),
          ],
        ),
      ],
    );
  }

  List<Widget> _buildWeek(BuildContext context) {
    return [
      _buildDay(context, day: "Segunda-feira", hour: "09:30 - 22:00"),
      _buildDay(context, day: "Segunda-feira", hour: "09:30 - 22:00"),
      _buildDay(context, day: "Segunda-feira", hour: "09:30 - 22:00"),
      _buildDay(context, day: "Segunda-feira", hour: "09:30 - 22:00"),
      _buildDay(context, day: "Segunda-feira", hour: "09:30 - 22:00"),
      _buildDay(context, day: "Segunda-feira", hour: "09:30 - 22:00"),
      _buildDay(context, day: "Segunda-feira", hour: "09:30 - 22:00"),
    ];
  }

  Widget _buildDay(BuildContext context,
      {@required String day, @required String hour}) {
    return Row(
      children: [
        day.label(context),
        SpacerBox.h8,
        hour.label(context),
      ],
    );
  }
}
