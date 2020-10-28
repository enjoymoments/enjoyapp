import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mozin/features/time_line/presentation/blocs/time_line_bloc/time_line_bloc.dart';
import 'package:mozin/features/time_line/presentation/pages/widgets/time_line_item.dart';
import 'package:mozin/features/time_line/presentation/pages/widgets/loadings/time_line_item_loading.dart';
import 'package:mozin/modules/config/setup.dart';
import 'package:mozin/package_view/custom_container.dart';
import 'package:mozin/package_view/spacer_box.dart';
import 'package:mozin/package_view/extension.dart';

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
    _timelineBloc = getItInstance<TimelineBloc>()..add(VerifyAuthenticated());

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
        if (state.unauthenticated) {
          return Center(
            child:
                "Quer registrar seus momentos?\nFaça login e aproveite."
                    .labelIntro(context),
          );
        }

        if (state.isLoading) {
          return _buildLoading();
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

  Widget _buildLoading() {
    return ListView.separated(
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: 5,
      itemBuilder: (context, index) => TimeLineItemLoading(),
      separatorBuilder: (context, index) => SpacerBox.v16,
    );
  }
}
