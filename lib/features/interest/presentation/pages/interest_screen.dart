import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:mozin/features/interest/presentation/bloc/interest_bloc.dart';
import 'package:mozin/features/interest/presentation/pages/widgets/filters/categories/details/interest_categories_details.dart';
import 'package:mozin/features/interest/presentation/pages/widgets/filters/categories/interest_categories.dart';
import 'package:mozin/features/interest/presentation/pages/widgets/filters/general/general_filters_screen.dart';
import 'package:mozin/features/places/presentation/blocs/places/places_bloc.dart';
import 'package:mozin/modules/config/router.gr.dart';
import 'package:mozin/modules/config/setup.dart';
import 'package:mozin/package_view/AppIcons.dart';
import 'package:mozin/package_view/custom_app_bar.dart';
import 'package:mozin/package_view/custom_icon.dart';
import 'package:mozin/package_view/custom_scaffold.dart';

class InterestScreen extends StatefulWidget {
  final bool isChangeFilter;

  const InterestScreen({Key key, @required this.isChangeFilter})
      : super(key: key);

  @override
  _InterestScreenState createState() => _InterestScreenState();
}

class _InterestScreenState extends State<InterestScreen> {
  final introKey = GlobalKey<IntroductionScreenState>();

  InterestBloc _interestBloc;

  @override
  void initState() {
    _interestBloc = getItInstance<InterestBloc>()..add(LoadCategories());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: _buildBody(context),
      appBar: _buildAppBar(context),
      bottomNavigationBar: null,
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return CustomAppBar(
      title: 'Interesses',
      context: context,
      onPressedBack: () => ExtendedNavigator.of(context).pop(),
    );
  }

  Widget _buildBody(BuildContext context) {
    return IntroductionScreen(
      key: introKey,
      pages: [
        _selectCategories(),
        _selectCategoriesDetails(),
        //TODO:in development
        //_selectedGeneralFilters(),
      ],
      onDone: () => _onIntroEnd(context),
      //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: false,
      skipFlex: 0,
      nextFlex: 0,
      // skip: Text(
      //   'Pular',
      //   style: TextStyle(color: Theme.of(context).primaryColor),
      // ),
      next: CustomIcon(
        icon: AppIcons.arrow_right,
        color: Theme.of(context).primaryColor,
      ),
      done: Text(
        'Filtrar',
        style: TextStyle(color: Theme.of(context).primaryColor),
      ),
      dotsDecorator: DotsDecorator(
        size: Size(10.0, 10.0),
        color: Theme.of(context).primaryColor,
        activeSize: Size(22.0, 10.0),
        activeColor: Color(0xFFFCBA03),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }

  void _onIntroEnd(context) {
    ExtendedNavigator.of(context).pop();

    if (widget.isChangeFilter != null && widget.isChangeFilter) {
      getItInstance<PlacesBloc>()
        ..add(GetCurrentPosition(_interestBloc.state.filtersSelected));
    } else {
      ExtendedNavigator.of(context).push(Routes.search_places_screen);
    }
  }

  PageViewModel _selectCategories() {
    return PageViewModel(
      titleWidget: SizedBox.shrink(),
      bodyWidget: InterestCategories(
        interestBloc: _interestBloc,
      ),
    );
  }

  PageViewModel _selectCategoriesDetails() {
    return PageViewModel(
      titleWidget: SizedBox.shrink(),
      bodyWidget: InterestCategoriesDetails(
        interestBloc: _interestBloc,
      ),
    );
  }

  PageViewModel _selectedGeneralFilters() {
    return PageViewModel(
      titleWidget: SizedBox.shrink(),
      bodyWidget: GeneralFiltersScreen(
        generalFilters: _interestBloc.state.filtersSelected.generalFilters,
      ),
    );
  }
}
