import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:mozin/features/places/data/models/place_model.dart';
import 'package:custom_view/custom_border.dart';
import 'package:custom_view/custom_container.dart';
import 'package:custom_view/spacer_box.dart';
import 'package:custom_view/extensions/extension.dart';

class PlaceAvailableWidget extends StatelessWidget {
  final PlaceModel? item;
  
  final ExpandableController controller = ExpandableController();

  PlaceAvailableWidget({Key? key, required this.item}) : super(key: key);

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
            collapsed: _buildCollapsed(context),
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
        (item!.openNow! ? "Aberto" : "Fechado").label(context, color: Theme.of(context).primaryColor),
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
      {required String day, required String hour}) {
    return Row(
      children: [
        day.label(context),
        SpacerBox.h8,
        hour.label(context),
      ],
    );
  }
}
