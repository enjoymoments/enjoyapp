import 'package:flutter/material.dart';
import 'package:mozin/features/interest/presentation/bloc/interest_bloc.dart';
import 'package:mozin/features/interest/presentation/pages/widgets/filters/general/enums/type_range_enum.dart';
import 'package:mozin/modules/config/setup.dart';
import 'package:custom_view/size_config.dart';
import 'package:custom_view/extensions/extension.dart';
import 'package:custom_view/spacer_box.dart';

class CustomRangeFilter extends StatefulWidget {
  final String title;

  final int divisions;
  final double min;
  final double max;

  final String textStartRange;
  final String textEndRange;

  final String prefixStartRange;
  final String prefixEndRange;

  final RangeValues selectedRanges;

  final TypeRangeEnum typeRange;

  const CustomRangeFilter({
    Key? key,
    required this.title,
    required this.divisions,
    required this.min,
    required this.max,
    required this.textStartRange,
    required this.textEndRange,
    required this.prefixStartRange,
    required this.prefixEndRange,
    required this.selectedRanges,
    required this.typeRange,
  }) : super(key: key);

  @override
  _CustomRangeFilterState createState() => _CustomRangeFilterState();
}

class _CustomRangeFilterState extends State<CustomRangeFilter> {
  late RangeValues _selectedRanges;
  InterestBloc? _interestBloc;

  @override
  void initState() {
    super.initState();
    _interestBloc = getItInstance<InterestBloc>();
    _selectedRanges = widget.selectedRanges;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.title.title(
          context,
        ),
        SpacerBox.v8,
        _buildContainer(),
      ],
    );
  }

  Widget _buildContainer() {
    return Container(
      width: double.infinity,
      height: SizeConfig.sizeByPixel(63),
      padding: EdgeInsets.only(left: 15, right: 15),
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).hintColor),
        borderRadius: BorderRadius.circular(5.0),
        color: Theme.of(context).hintColor.withOpacity(0.2),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildIndicator(widget.textStartRange, widget.prefixStartRange),
          _buildSlider(),
          _buildIndicator(widget.textEndRange, widget.prefixEndRange),
        ],
      ),
    );
  }

  Widget _buildSlider() {
    return Expanded(
      flex: 1,
      child: RangeSlider(
        values: _selectedRanges,
        activeColor: Theme.of(context).primaryColor,
        inactiveColor: Theme.of(context).hintColor,
        min: widget.min,
        max: widget.max,
        divisions: widget.divisions,
        onChanged: (RangeValues value) {
          _invokeChange(value);

          setState(() {
            _selectedRanges = value;
          });
        },
        labels:
            RangeLabels('${_selectedRanges.start}', '${_selectedRanges.end}'),
      ),
    );
  }

  Widget _buildIndicator(String text, String prefix) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        text.description(context),
        prefix.description(context),
      ],
    );
  }

  void _invokeChange(RangeValues value) {
    if (widget.typeRange == TypeRangeEnum.price) {
      _interestBloc!
          .add(ChangePrice(minPrice: value.start, maxPrice: value.end));
    } else if (widget.typeRange == TypeRangeEnum.distance) {
      _interestBloc!
          .add(ChangeDistance(minDistance: value.start, maxDistance: value.end));
    } else if (widget.typeRange == TypeRangeEnum.time) {
      _interestBloc!
          .add(ChangeTime(minTime: value.start, maxTime: value.end));
    }
  }
}
