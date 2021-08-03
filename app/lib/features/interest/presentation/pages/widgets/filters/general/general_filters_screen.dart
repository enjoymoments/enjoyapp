import 'package:flutter/material.dart';
import 'package:mozin/features/interest/presentation/pages/widgets/filters/general/enums/type_range_enum.dart';
import 'package:mozin/features/interest/presentation/pages/widgets/filters/general/widgets/custom_range_filter.dart';
import 'package:mozin/modules/shared/filter_choosed/models/general_filters_model.dart';
import 'package:custom_view/custom_container.dart';
import 'package:custom_view/extensions/extension.dart';
import 'package:custom_view/spacer_box.dart';

class GeneralFiltersScreen extends StatelessWidget {
  final GeneralFilterModel generalFilters;

  const GeneralFiltersScreen({Key key, @required this.generalFilters}) : super(key: key);
  
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
      typeRange: TypeRangeEnum.price,
      title: 'Valores',
      divisions: 10,
      min: 0,
      max: 2.0,
      textStartRange: '0',
      prefixStartRange: 'R\$',
      textEndRange: '2000',
      prefixEndRange: 'R\$',
      selectedRanges: RangeValues(generalFilters.minPrice, generalFilters.maxPrice),
    );
  }

  Widget _buildFilterDistance() {
    return CustomRangeFilter(
      typeRange: TypeRangeEnum.distance,
      title: 'Distância',
      divisions: 20,
      min: 0,
      max: 20,
      textStartRange: '0',
      prefixStartRange: 'Km',
      textEndRange: '20',
      prefixEndRange: 'Km',
      selectedRanges: RangeValues(generalFilters.minDistance, generalFilters.maxDistance),
    );
  }

  Widget _buildFilterHour() {
    return CustomRangeFilter(
      typeRange: TypeRangeEnum.time,
      title: 'Horário',
      divisions: 10,
      min: 0,
      max: 2.0,
      textStartRange: '00:00',
      prefixStartRange: 'Hs',
      textEndRange: '23:59',
      prefixEndRange: 'Hs',
      selectedRanges: RangeValues(generalFilters.minTime, generalFilters.maxTime),
    );
  }
}
