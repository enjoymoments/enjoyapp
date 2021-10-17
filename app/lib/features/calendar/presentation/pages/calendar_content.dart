import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mozin/features/calendar/data/models/task_calendar_model.dart';
import 'package:mozin/features/calendar/presentation/blocs/cubit/calendar_cubit.dart';
import 'package:mozin/features/calendar/presentation/pages/widgets/calendar_content_loading.dart';
import 'package:mozin/modules/config/router.gr.dart';
import 'package:mozin/modules/config/setup.dart';
import 'package:custom_view/size_config.dart';
import 'package:custom_view/AppIcons.dart';
import 'package:custom_view/custom_container.dart';
import 'package:custom_view/custom_icon.dart';
import 'package:custom_view/spacer_box.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:custom_view/extensions/extension.dart';
import 'package:mozin/modules/shared/core_migrate/extension_utils.dart';

class CalendarContent extends StatefulWidget {
  @override
  _CalendarContentState createState() => _CalendarContentState();
}

class _CalendarContentState extends State<CalendarContent>
    with TickerProviderStateMixin {
  late CalendarCubit _calendarCubit;
  late AnimationController _animationController;
  late DateTime _selectedDay;

  @override
  void initState() {
    super.initState();
    _selectedDay = DateTime.now();

    _calendarCubit = getItInstance<CalendarCubit>()..loadTasks();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: CustomContainer(
        child: BlocBuilder<CalendarCubit, CalendarState>(
          bloc: _calendarCubit,
          builder: (context, state) {
            if (state.model != null) {
              return Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  _buildTableCalendarWithBuilders(state),
                  SpacerBox.v8,
                  ..._buildEventList(state),
                ],
              );
            }

            return CalendarContentLoading();
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Widget _buildTableCalendarWithBuilders(CalendarState state) {
    return TableCalendar(
      locale: 'pt_BR',
      calendarFormat: CalendarFormat.month,
      eventLoader: (DateTime date) {
        List? _events = _calendarCubit.state.events[date.clearTime()];
        return _events ?? [];
      },
      firstDay: DateTime.utc(2010, 10, 16),
      lastDay: DateTime.utc(2030, 3, 14),
      focusedDay: _selectedDay,
      startingDayOfWeek: StartingDayOfWeek.sunday,
      availableGestures: AvailableGestures.all,
      availableCalendarFormats: const {
        CalendarFormat.month: '',
        CalendarFormat.week: '',
      },
      calendarStyle: CalendarStyle(
        outsideDaysVisible: false,
        defaultTextStyle: Theme.of(context).textTheme.headline5!,
        weekendTextStyle: Theme.of(context)
            .textTheme
            .headline5!
            .copyWith(color: Theme.of(context).primaryColor),
        holidayTextStyle: Theme.of(context)
            .textTheme
            .headline5!
            .copyWith(color: Theme.of(context).primaryColor),
      ),
      daysOfWeekHeight: 30,
      daysOfWeekStyle: DaysOfWeekStyle(
        weekdayStyle: Theme.of(context).textTheme.headline5!,
        weekendStyle: Theme.of(context)
            .textTheme
            .headline5!
            .copyWith(color: Theme.of(context).primaryColor),
      ),
      headerStyle: HeaderStyle(
        titleCentered: true,
        formatButtonVisible: false,
        leftChevronIcon: Icon(
          AppIcons.chevron_left,
          color: Theme.of(context).iconTheme.color,
          size: Theme.of(context).iconTheme.size,
        ),
        rightChevronIcon: Icon(
          AppIcons.chevron_right,
          color: Theme.of(context).iconTheme.color,
          size: Theme.of(context).iconTheme.size,
        ),
        titleTextStyle: Theme.of(context)
            .textTheme
            .headline5!
            .copyWith(color: Theme.of(context).primaryColor),
      ),
      selectedDayPredicate: (day) {
        return isSameDay(_selectedDay, day);
      },
      calendarBuilders: CalendarBuilders(
        selectedBuilder: (context, date, _) {
          return FadeTransition(
            opacity: Tween(begin: 0.0, end: 1.0).animate(_animationController),
            child: Container(
                margin: EdgeInsets.all(SizeConfig.sizeByPixel(4.0)),
                padding: EdgeInsets.only(
                  top: SizeConfig.sizeByPixel(5.0),
                  left: SizeConfig.sizeByPixel(6.0),
                ),
                color: Theme.of(context).hintColor,
                width: SizeConfig.sizeByPixel(100),
                height: SizeConfig.sizeByPixel(100),
                child: '${date.day}'.label(context)),
          );
        },
        todayBuilder: (context, date, _) {
          return Container(
            margin: EdgeInsets.all(SizeConfig.sizeByPixel(4.0)),
            padding: EdgeInsets.only(
              top: SizeConfig.sizeByPixel(5.0),
              left: SizeConfig.sizeByPixel(6.0),
            ),
            color: Theme.of(context).primaryColor,
            width: SizeConfig.sizeByPixel(100),
            height: SizeConfig.sizeByPixel(100),
            child: '${date.day}'
                .label(context, color: Theme.of(context).backgroundColor),
          );
        },
        markerBuilder: (context, date, events) {
          if (events.isNotEmpty) {
            return Positioned(
              right: 1,
              bottom: 1,
              child: _buildEventsMarker(date, events),
            );
          }

          return SizedBox.shrink();
        },
      ),
      onDaySelected: (DateTime selectedDay, DateTime focusedDay) {
        _selectedDay = selectedDay;

        List? _events = _calendarCubit.state.events[selectedDay.clearTime()];
        _calendarCubit.selectedEvents(_events ?? []);
        _animationController.forward(from: 0.0);
      },
    );
  }

  Widget _buildEventsMarker(DateTime date, List events) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: DateTime.now().clearTime() == date.clearTime()
            ? Theme.of(context).hintColor
            : Theme.of(context).primaryColor,
      ),
      width: SizeConfig.sizeByPixel(16.0),
      height: SizeConfig.sizeByPixel(16.0),
      child: Center(
        child: Text(
          '${events.length}',
          style: TextStyle().copyWith(
            color: DateTime.now().clearTime() == date.clearTime()
                ? Theme.of(context).primaryColor
                : Theme.of(context).backgroundColor,
            fontSize: 12.0,
          ),
        ),
      ),
    );
  }

  List<Widget> _buildEventList(CalendarState state) {
    return state.selectedEvents!.map(
      (event) {
        var _eventCast = event as TaskCalendarModel;
        return InkWell(
          onTap: () {
            AutoRouter.of(context)
                .push(Add_calendar_screen(taskModel: _eventCast));
          },
          child: Container(
            width: SizeConfig.screenWidth,
            margin: EdgeInsets.symmetric(vertical: SpacerBox.v8.height!),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _eventCast.title!.title(context),
                        SpacerBox.v4,
                        ..._buildDescription(_eventCast),
                        _eventCast.dateTime!
                            .formattedHourMinute()
                            .label(context),
                      ],
                    ),
                    CustomIcon(
                      icon: AppIcons.angle_right,
                    ),
                  ],
                ),
                SpacerBox.v16,
                Divider(
                  color: Theme.of(context).hintColor,
                  height: SizeConfig.sizeByPixel(4),
                ),
              ],
            ),
          ),
        );
      },
    ).toList();
  }

  List<Widget> _buildDescription(TaskCalendarModel eventCast) {
    if (eventCast.description != null && eventCast.description!.isNotEmpty) {
      return [
        eventCast.description!.description(context),
        SpacerBox.v4,
      ];
    }

    return [];
  }
}
