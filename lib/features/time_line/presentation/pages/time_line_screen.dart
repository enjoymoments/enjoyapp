import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mozin/features/time_line/presentation/blocs/time_line_bloc/time_line_bloc.dart';
import 'package:mozin/features/time_line/presentation/pages/widgets/time_line_item.dart';
import 'package:mozin/modules/config/setup.dart';
import 'package:mozin/package_view/custom_circular_progress_indicador.dart';
import 'package:mozin/package_view/custom_container.dart';

class TimeLineScreen extends StatefulWidget {
  @override
  _TimeLineScreenState createState() => _TimeLineScreenState();
}

class _TimeLineScreenState extends State<TimeLineScreen> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  TimelineBloc _timelineBloc;

  @override
  void initState() {
    _timelineBloc = getItInstance<TimelineBloc>();
    _timelineBloc.add(LoadPosts());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  Widget _buildBody() {
    return BlocBuilder<TimelineBloc, TimelineState>(
      cubit: _timelineBloc,
      builder: (context, state) {
        if (state.isLoading) {
          return CustomCircularProgressIndicator();
        }

        if (state.posts.isNotEmpty) {
          return CustomContainer(
            child: RefreshIndicator(
              key: _refreshIndicatorKey,
              color: Theme.of(context).primaryColor,
              onRefresh: () async {
                _timelineBloc.add(LoadPosts());
              },
              child: ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: state.posts.length,
                itemBuilder: (context, index) => TimeLineItem(
                  item: state.posts[index],
                  timelineBloc: _timelineBloc,
                ),
              ),
            ),
          );
        }

        return SizedBox.shrink();
      },
    );
  }
}
