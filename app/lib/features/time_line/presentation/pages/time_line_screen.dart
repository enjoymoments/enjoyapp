import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mozin/features/time_line/presentation/blocs/time_line_bloc/time_line_bloc.dart';
import 'package:mozin/features/time_line/presentation/pages/widgets/time_line_avatar.dart';
import 'package:mozin/features/time_line/presentation/pages/widgets/time_line_item.dart';
import 'package:mozin/features/time_line/presentation/pages/widgets/loadings/time_line_item_loading.dart';
import 'package:mozin/modules/config/setup.dart';
import 'package:custom_view/size_config.dart';
import 'package:mozin/modules/shared/general/enums.dart';
import 'package:custom_view/custom_container.dart';
import 'package:custom_view/custom_divider.dart';
import 'package:custom_view/spacer_box.dart';
import 'package:custom_view/extensions/extension.dart';

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
    return CustomContainer(
      child: _buildBody(),
    );
  }


  Widget _buildBody() {
    return BlocBuilder<TimelineBloc, TimelineState>(
      cubit: _timelineBloc,
      builder: (context, state) {
        if (state.unauthenticated) {
          return Center(
            child: "Quer registrar seus momentos?\nFaça login e aproveite."
                .labelIntro(context),
          );
        }

        if (state.isLoading) {
          return _buildLoading();
        }

        if (state.posts.isNotEmpty) {
          return RefreshIndicator(
            key: _refreshIndicatorKey,
            color: Theme.of(context).primaryColor,
            onRefresh: () async {
              _timelineBloc.add(LoadPosts());
            },
            child: ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: state.posts.length,
              separatorBuilder: (context, index) => SpacerBox.v16,
              itemBuilder: (context, index) {
                return TimeLineItem(
                  item: state.posts[index],
                  timelineBloc: _timelineBloc,
                );
              },
            ),
          );
        }

        return Center(
          child: "Que tal criar a primeira postagem?".labelIntro(context),
        );
      },
    );
  }

//TODO:in development - timeline
  // Widget _buildTimelinesContent(TimelineState state) {
  //   return Column(
  //     children: [
  //       Container(
  //         height: SizeConfig.sizeByPixel(65),
  //         child: ListView.separated(
  //           physics: const AlwaysScrollableScrollPhysics(),
  //           scrollDirection: Axis.horizontal,
  //           itemCount: state.timelines.length,
  //           itemBuilder: (context, index) {
  //             var _item = state.timelines[index];

  //             return InkWell(
  //               onTap: () {
  //                 if (state.timelineSelected.id != _item.id) {
  //                   _timelineBloc.add(SelectedTimeline(_item));
  //                 }
  //               },
  //               child: TimeLineAvatar(
  //                 selected: state.timelineSelected.id == _item.id,
  //                 name: _item.type == TimeLineTypeEnum.Personal ? 'Você' : 'Casal',
  //                 backgroundImage: _item.type == TimeLineTypeEnum.Personal
  //                     ? null
  //                     : AssetImage('assets/images/default_avatar.png'),
  //               ),
  //             );
  //           },
  //           separatorBuilder: (context, index) => SpacerBox.h16,
  //         ),
  //       ),
  //       CustomDivider(),
  //       SpacerBox.v8,
  //     ],
  //   );
  // }

  Widget _buildLoading() {
    return ListView.separated(
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: 5,
      itemBuilder: (context, index) => TimeLineItemLoading(),
      separatorBuilder: (context, index) => SpacerBox.v16,
    );
  }
}
