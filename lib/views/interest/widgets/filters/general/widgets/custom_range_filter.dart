import 'package:flutter/material.dart';
import 'package:mozin/size_config.dart';
import 'package:mozin/views/shared/extension.dart';
import 'package:mozin/views/shared/spacer_box.dart';

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

  const CustomRangeFilter({
    Key key,
    @required this.title,
    @required this.divisions,
    @required this.min,
    @required this.max,
    @required this.textStartRange,
    @required this.textEndRange,
    @required this.prefixStartRange,
    @required this.prefixEndRange,
    @required this.selectedRanges,
  }) : super(key: key);

  @override
  _CustomRangeFilterState createState() => _CustomRangeFilterState();
}

class _CustomRangeFilterState extends State<CustomRangeFilter> {
  RangeValues _selectedRanges;

  @override
  void initState() {
    super.initState();
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
          setState(() {
            _selectedRanges = value;
          });
        },
        labels: RangeLabels('${_selectedRanges.start}', '${_selectedRanges.end}'),
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
}
