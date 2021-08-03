import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mozin/features/places/presentation/blocs/places/places_bloc.dart';
import 'package:mozin/features/places/presentation/pages/widgets/categories/categories_places.dart';
import 'package:mozin/features/places/presentation/pages/widgets/loadings/place_card_item_loading.dart';
import 'package:mozin/modules/config/router.gr.dart';
import 'package:mozin/modules/config/setup.dart';
import 'package:mozin/modules/config/size_config.dart';
import 'package:mozin/package_view/AppIcons.dart';
import 'package:mozin/package_view/custom_app_bar.dart';
import 'package:mozin/package_view/custom_container.dart';
import 'package:mozin/package_view/custom_icon.dart';
import 'package:mozin/package_view/custom_scaffold.dart';
import 'package:mozin/package_view/extension.dart';

class SearchPlacesScreen extends StatefulWidget {
  @override
  _SearchPlacesScreenState createState() => _SearchPlacesScreenState();
}

class _SearchPlacesScreenState extends State<SearchPlacesScreen> {
  PlacesBloc _placesBloc;

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    _placesBloc = getItInstance<PlacesBloc>()
      ..add(GetCurrentPosition());
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

  Widget _buildBody() {
    return CustomContainer(
      child: BlocBuilder<PlacesBloc, PlacesState>(
        cubit: _placesBloc,
        builder: (context, state) {
          if (state.isLoading) {
            return PlaceCardItemLoading();
          }

          if (state.model.places != null && state.model.places.length > 0) {
            return CategoriesPlaces(
              places: state.model.places,
            );
          }

          if (state.model.places != null && state.model.places.length == 0) {
            return _generateContent(
              SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Container(
                  child: Center(child: "Ops...\n não encontramos nada".labelIntro(context)),
                  height: SizeConfig.screenHeight / 1.5,
                ),
              ),
            );
          }

          if (state.isError) {
            return _generateContent(
              SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Container(
                  child: Center(
                      child: "Ops... houve um erro.\nTente novamente"
                          .labelIntro(context)),
                  height: SizeConfig.screenHeight / 1.5,
                ),
              ),
            );
          }

          return SizedBox.shrink();
        },
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return CustomAppBar(
      title: 'Sugestões',
      context: context,
      onPressedBack: () => Navigator.of(context).pop(),
      actions: [
        IconButton(
          icon: CustomIcon(icon: AppIcons.filter),
          onPressed: () {
            ExtendedNavigator.of(context).push(Routes.interest_screen,
                arguments: InterestScreenArguments(isChangeFilter: true));
          },
        ),
      ],
    );
  }

  Widget _generateContent(Widget child) {
    return RefreshIndicator(
      key: _refreshIndicatorKey,
      color: Theme.of(context).primaryColor,
      onRefresh: () async {
        _placesBloc
            .add(GetCurrentPosition());
      },
      child: child,
    );
  }
}
