import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mozin/features/time_line/presentation/blocs/time_line_bloc/time_line_bloc.dart';
import 'package:mozin/features/time_line/presentation/pages/widgets/time_line_item.dart';
import 'package:mozin/features/time_line/presentation/pages/widgets/loadings/time_line_item_loading.dart';
import 'package:mozin/modules/config/setup.dart';
import 'package:custom_view/custom_container.dart';
import 'package:custom_view/spacer_box.dart';
import 'package:custom_view/extensions/extension.dart';

class TimeLineScreen extends StatefulWidget {
  @override
  _TimeLineScreenState createState() => _TimeLineScreenState();
}

class _TimeLineScreenState extends State<TimeLineScreen> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  TimelineBloc? _timelineBloc;

  @override
  void initState() {
    _timelineBloc = getItInstance<TimelineBloc>()..add(InitLoad());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: _buildBody(),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<TimelineBloc, TimelineState>(
      bloc: _timelineBloc,
      builder: (context, state) {
        if (state.isLoading!) {
          return _buildLoading();
        }

        if (state.posts!.isNotEmpty) {
          return RefreshIndicator(
            key: _refreshIndicatorKey,
            color: Theme.of(context).primaryColor,
            onRefresh: () async {
              _timelineBloc!.add(LoadPosts());
            },
            child: ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: state.posts!.length,
              separatorBuilder: (context, index) => SpacerBox.v16,
              itemBuilder: (context, index) {
                return TimeLineItem(
                  item: state.posts![index],
                  timelineBloc: _timelineBloc,
                );
              },
            ),
          );
        }

        if (state.isError!) {
          return Center(
            child: "Ops, houve um erro. Tente novamente".labelIntro(context),
          );
        }

        return Center(
          child: "Que tal criar a primeira postagem?".labelIntro(context),
        );
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
