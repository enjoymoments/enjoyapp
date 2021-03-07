import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mozin/features/calendar/data/models/activity_item_model.dart';
import 'package:mozin/features/calendar/data/models/activity_model.dart';
import 'package:mozin/features/calendar/data/models/add_activity_calendar_model.dart';
import 'package:mozin/features/calendar/presentation/blocs/add_activity_cubit/add_activity_cubit.dart';
import 'package:mozin/features/calendar/presentation/blocs/add_calendar_cubit/add_calendar_cubit.dart';
import 'package:mozin/features/calendar/presentation/pages/widgets/activity_icon.dart';
import 'package:mozin/features/calendar/presentation/pages/widgets/activity_loading.dart';
import 'package:mozin/package_view/custom_app_bar.dart';
import 'package:mozin/package_view/custom_container.dart';
import 'package:mozin/package_view/custom_scaffold.dart';
import 'package:mozin/package_view/extension.dart';
import 'package:mozin/package_view/spacer_box.dart';

class AddActivityScreen extends StatelessWidget {
  final AddActivityCubit activityCubit;
  final AddCalendarCubit addCalendarCubit;

  const AddActivityScreen({
    Key key,
    @required this.activityCubit,
    @required this.addCalendarCubit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: _buildBody(),
      appBar: _buildAppBar(context),
      bottomNavigationBar: null,
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      title: 'Tipos de atividades',
      context: context,
      onPressedBack: () {
        ExtendedNavigator.of(context).pop();
      },
    );
  }

  Widget _buildBody() {
    return BlocBuilder<AddActivityCubit, AddActivityState>(
      cubit: activityCubit,
      builder: (context, state) {
        if (state.activities != null && state.activities.length > 0) {
          return _buildContent(context, state.activities);
        }

        return ActivityLoading();
      },
    );
  }

  Widget _buildContent(BuildContext context, List<ActivityModel> activities) {
    return SingleChildScrollView(
      child: CustomContainer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: activities.buildWithBetweenSpace<ActivityModel>(
            space: SpacerBox.v34,
            builderItem: (e) {
              return _buildSection(context, e);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildSection(BuildContext context, ActivityModel section) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        section.sessionName.label(context),
        Wrap(
          children: section.activities.buildWithBetweenSpace<ActivityItemModel>(
            space: SpacerBox.h16,
            builderItem: (e) {
              return ActivityIcon(
                item: e,
                onPressed: (ActivityItemModel item) {
                  if (item.isSelected) {
                    addCalendarCubit.addActivity(
                        AddActivityCalendarModel(
                            sessionId: section.id, activityId: item.id));
                  } else {
                    addCalendarCubit.removeActivity(
                        AddActivityCalendarModel(
                            sessionId: section.id, activityId: item.id));
                  }
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
