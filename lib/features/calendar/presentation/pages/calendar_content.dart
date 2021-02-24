import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mozin/features/calendar/data/models/task_calendar_model.dart';
import 'package:mozin/features/calendar/presentation/blocs/cubit/calendar_cubit.dart';
import 'package:mozin/features/calendar/presentation/pages/widgets/calendar_content_loading.dart';
import 'package:mozin/modules/config/setup.dart';
import 'package:mozin/modules/config/size_config.dart';
import 'package:mozin/package_view/AppIcons.dart';
import 'package:mozin/package_view/custom_container.dart';
import 'package:mozin/package_view/custom_icon.dart';
import 'package:mozin/package_view/spacer_box.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:mozin/package_view/extension.dart';

class CalendarContent extends StatefulWidget {
  @override
  _CalendarContentState createState() => _CalendarContentState();
}

class _CalendarContentState extends State<CalendarContent>
    with TickerProviderStateMixin {
  CalendarCubit _calendarCubit;
  AnimationController _animationController;
  CalendarController _calendarController;

  @override
  void initState() {
    super.initState();
    _calendarCubit = getItInstance<CalendarCubit>()..loadTasks();

    _calendarController = CalendarController();

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
          cubit: _calendarCubit,
          builder: (context, state) {
            if (state.model.length > 0) {
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
    _calendarController.dispose();
    super.dispose();
  }

  Widget _buildTableCalendarWithBuilders(CalendarState state) {
    return TableCalendar(
      locale: 'pt_BR',
      calendarController: _calendarController,
      events: state.events,
      initialCalendarFormat: CalendarFormat.month,
      formatAnimation: FormatAnimation.slide,
      startingDayOfWeek: StartingDayOfWeek.sunday,
      availableGestures: AvailableGestures.all,
      availableCalendarFormats: const {
        CalendarFormat.month: '',
        CalendarFormat.week: '',
      },
      calendarStyle: CalendarStyle(
        outsideDaysVisible: false,
        weekdayStyle:
            Theme.of(context).textTheme.headline5.copyWith(fontSize: 16),
        weekendStyle: Theme.of(context)
            .textTheme
            .headline5
            .copyWith(fontSize: 16, color: Theme.of(context).primaryColor),
        holidayStyle: Theme.of(context)
            .textTheme
            .headline5
            .copyWith(fontSize: 16, color: Theme.of(context).primaryColor),
      ),
      daysOfWeekStyle: DaysOfWeekStyle(
        weekdayStyle:
            Theme.of(context).textTheme.headline5.copyWith(fontSize: 16),
        weekendStyle: Theme.of(context)
            .textTheme
            .headline5
            .copyWith(fontSize: 16, color: Theme.of(context).primaryColor),
      ),
      headerStyle: HeaderStyle(
        centerHeaderTitle: true,
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
            .headline6
            .copyWith(color: Theme.of(context).primaryColor),
      ),
      builders: CalendarBuilders(
        selectedDayBuilder: (context, date, _) {
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
              child: '${date.day}'.label(context),
            ),
          );
        },
        todayDayBuilder: (context, date, _) {
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
        markersBuilder: (context, date, events, holidays) {
          final children = <Widget>[];

          if (events.isNotEmpty) {
            children.add(
              Positioned(
                right: 1,
                bottom: 1,
                child: _buildEventsMarker(date, events),
              ),
            );
          }

          if (holidays.isNotEmpty) {
            children.add(
              Positioned(
                right: -2,
                top: -2,
                child: _buildHolidaysMarker(),
              ),
            );
          }

          return children;
        },
      ),
      onDaySelected: (date, events, holidays) {
        _calendarCubit.selectedEvents(events);
        _animationController.forward(from: 0.0);
      },
    );
  }

  Widget _buildEventsMarker(DateTime date, List events) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: _calendarController.isToday(date)
            ? Theme.of(context).hintColor
            : Theme.of(context).primaryColor,
      ),
      width: SizeConfig.sizeByPixel(16.0),
      height: SizeConfig.sizeByPixel(16.0),
      child: Center(
        child: Text(
          '${events.length}',
          style: TextStyle().copyWith(
            color: _calendarController.isToday(date)
                ? Theme.of(context).primaryColor
                : Theme.of(context).backgroundColor,
            fontSize: 12.0,
          ),
        ),
      ),
    );
  }

  Widget _buildHolidaysMarker() {
    return Icon(
      Icons.add_box,
      size: SizeConfig.sizeByPixel(20.0),
      color: Colors.blueGrey[800],
    );
  }

  List<Widget> _buildEventList(CalendarState state) {
    return state.selectedEvents.map(
      (event) {
        var _eventCast = event as TaskCalendarModel;
        return InkWell(
          onTap: () {
            
          },
          child: Container(
            width: SizeConfig.screenWidth,
            margin: EdgeInsets.symmetric(vertical: SpacerBox.v8.height),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _eventCast.title.title(context),
                        SpacerBox.v4,
                        "Bla bla bla".description(context),
                        SpacerBox.v4,
                        _eventCast.dateTime
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
}
