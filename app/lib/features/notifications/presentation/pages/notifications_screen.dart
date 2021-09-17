import 'package:custom_view/custom_app_bar.dart';
import 'package:custom_view/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mozin/features/notifications/presentation/bloc/notifications_cubit.dart';
import 'package:mozin/features/notifications/presentation/pages/widgets/notification_item.dart';
import 'package:mozin/features/notifications/presentation/pages/widgets/notifications_not_autenticated.dart';
import 'package:mozin/features/notifications/presentation/pages/widgets/notifications_loading.dart';
import 'package:mozin/modules/config/setup.dart';
import 'package:custom_view/custom_container.dart';
import 'package:custom_view/custom_divider.dart';
import 'package:custom_view/extensions/extension.dart';

import 'package:custom_view/spacer_box.dart';

class NotificationsScreen extends StatefulWidget {
  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  NotificationsCubit _notificationsCubit;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    _notificationsCubit = getItInstance<NotificationsCubit>()
      ..getNotifications();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: _buildBody(),
      appBar: _buildAppBar(context),
      bottomNavigationBar: null,
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return CustomAppBar(
      title: 'Notificações',
      context: context,
      onPressedBack: () => Navigator.of(context).pop(),
    );
  }

  Widget _buildBody() {
    return CustomContainer(
      child: RefreshIndicator(
        key: _refreshIndicatorKey,
        color: Theme.of(context).primaryColor,
        onRefresh: () async {
          _notificationsCubit.getNotifications(byPass: true);
        },
        child: BlocBuilder<NotificationsCubit, NotificationsState>(
          bloc: _notificationsCubit,
          builder: (BuildContext context, NotificationsState state) {
            if (state.notAutenticated == null || state.notAutenticated) {
              return NotificationsNotAutenticated();
            }

            if (state.isLoading) {
              return NotificationsLoading();
            }

            if (state.notifications.length > 0) {
              return ListView.separated(
                separatorBuilder: (context, index) => _buildSeparator(),
                itemCount: state.notifications.length,
                itemBuilder: (context, index) => NotificationItem(
                  item: state.notifications[index],
                ),
              );
            }

            return Center(
                child: "Ops...\n não encontramos nada".labelIntro(context));
          },
        ),
      ),
    );
  }

  Widget _buildSeparator() {
    return Column(
      children: [
        SpacerBox.v16,
        CustomDivider(),
        SpacerBox.v16,
      ],
    );
  }
}
