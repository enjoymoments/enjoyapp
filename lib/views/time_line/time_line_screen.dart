import 'package:flutter/material.dart';
import 'package:mozin/views/shared/custom_container.dart';
import 'package:mozin/views/time_line/components/time_line_item.dart';

class TimeLineScreen extends StatefulWidget {
  @override
  _TimeLineScreenState createState() => _TimeLineScreenState();
}

class _TimeLineScreenState extends State<TimeLineScreen> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  Widget _buildBody() {
    return CustomContainer(
      child: _buildItems(),
    );
  }

  Widget _buildItems() {
    return RefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: () async {},
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: 2,
        itemBuilder: (context, index) => _buildItem(),
      ),
    );
  }

  Widget _buildItem() {
    return TimeLineItem();
  }
}
