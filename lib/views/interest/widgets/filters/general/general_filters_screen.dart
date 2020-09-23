import 'package:flutter/material.dart';
import 'package:mozin/views/interest/widgets/filters/general/widgets/custom_range_filter.dart';
import 'package:mozin/views/shared/custom_container.dart';
import 'package:mozin/views/shared/extension.dart';
import 'package:mozin/views/shared/spacer_box.dart';

class GeneralFiltersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      customMargin: EdgeInsets.only(top: 0),
      child: Column(
        children: [
          "Informe outros filtros".title(context),
          SpacerBox.v20,
          _buildFilterPrice(),
          SpacerBox.v20,
          _buildFilterDistance(),
          SpacerBox.v20,
          _buildFilterHour(),
        ],
      ),
    );
  }

  Widget _buildFilterPrice() {
    return CustomRangeFilter(
      title: 'Valores',
      divisions: 10,
      min: 0,
      max: 2.0,
      textStartRange: '0',
      prefixStartRange: 'R\$',
      textEndRange: '2000',
      prefixEndRange: 'R\$',
      selectedRanges: RangeValues(0.0, 2.0),
    );
  }

  Widget _buildFilterDistance() {
    return CustomRangeFilter(
      title: 'Distância',
      divisions: 10,
      min: 0,
      max: 2.0,
      textStartRange: '0',
      prefixStartRange: 'Km',
      textEndRange: '100',
      prefixEndRange: 'Km',
      selectedRanges: RangeValues(0.0, 2.0),
    );
  }

  Widget _buildFilterHour() {
    return CustomRangeFilter(
      title: 'Horário',
      divisions: 10,
      min: 0,
      max: 2.0,
      textStartRange: '00:00',
      prefixStartRange: 'Hs',
      textEndRange: '23:59',
      prefixEndRange: 'Hs',
      selectedRanges: RangeValues(0.0, 2.0),
    );
  }
}
