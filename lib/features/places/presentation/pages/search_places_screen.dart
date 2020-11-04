import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mozin/features/interest/presentation/bloc/interest_bloc.dart';
import 'package:mozin/features/interest/presentation/pages/widgets/enums/interest_menu_enum.dart';
import 'package:mozin/features/interest/presentation/pages/widgets/interest_menu.dart';
import 'package:mozin/features/places/presentation/bloc/places_bloc.dart';
import 'package:mozin/features/places/presentation/pages/widgets/loadings/place_card_item_loading.dart';
import 'package:mozin/features/places/presentation/pages/widgets/place_card_item.dart';
import 'package:mozin/modules/config/router.gr.dart';
import 'package:mozin/modules/config/setup.dart';
import 'package:mozin/package_view/custom_app_bar.dart';
import 'package:mozin/package_view/custom_container.dart';
import 'package:mozin/package_view/custom_scaffold.dart';
import 'package:mozin/package_view/spacer_box.dart';
import 'package:mozin/package_view/extension.dart';

class SearchPlacesScreen extends StatefulWidget {
  @override
  _SearchPlacesScreenState createState() => _SearchPlacesScreenState();
}

class _SearchPlacesScreenState extends State<SearchPlacesScreen> {
  PlacesBloc _placesBloc;
  InterestBloc _interestBloc;

  @override
  void initState() {
    _interestBloc = getItInstance<InterestBloc>();
    _placesBloc = getItInstance<PlacesBloc>()..add(GetCurrentPosition(_interestBloc.state.filtersSelected));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: _buildBody(),
      appBar: _buildAppBar(context),
      bottomNavigationBar: InterestMenu(onTap: (itemSelected) {
        if (itemSelected == INTEREST_MENU_ENUM.CHANGE_FILTER) {
          ExtendedNavigator.of(context).push(Routes.interest_screen, arguments: InterestScreenArguments(isChangeFilter: true));
        }
      }),
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
            return _generateItems(state);
          }

          if(state.model.places != null && state.model.places.length == 0) {
            return Center(child: "Nada encontrado".labelIntro(context));
          }

          if(state.isError) {
            return Center(child: "Ops... houve um erro.\nTente novamente".labelIntro(context));
          }

          return SizedBox.shrink();
        },
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return CustomAppBar(
      title: 'Sugestões',
      iconColors: Theme.of(context).backgroundColor,
      onPressedBack: () => Navigator.of(context).pop(),
    );
  }

  Widget _generateItems(PlacesState state) {
    return ListView.separated(
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: state.model.places.length,
      itemBuilder: (context, index) {
        var item = state.model.places[index];
        return PlaceCardItem(
          item: item,
        );
      },
      separatorBuilder: (context, index) => SpacerBox.v16,
    );
  }
}
