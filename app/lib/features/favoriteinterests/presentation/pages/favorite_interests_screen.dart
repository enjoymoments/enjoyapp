import 'package:custom_view/custom_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mozin/features/favoriteinterests/presentation/bloc/favorite_interests_bloc.dart';
import 'package:mozin/features/favoriteinterests/presentation/bloc/favorite_interests_event.dart';
import 'package:mozin/features/favoriteinterests/presentation/bloc/favorite_interests_state.dart';
import 'package:mozin/features/places/presentation/pages/widgets/categories/categories_places.dart';
import 'package:mozin/features/places/presentation/pages/widgets/loadings/place_card_item_loading.dart';
import 'package:mozin/modules/config/setup.dart';

class FavoriteInterestsScreen extends StatefulWidget {
  @override
  _FavoriteInterestsScreenState createState() =>
      _FavoriteInterestsScreenState();
}

class _FavoriteInterestsScreenState extends State<FavoriteInterestsScreen> {
  FavoriteInterestsBloc? _favoriteInterestsBloc;

  @override
  void initState() {
    _favoriteInterestsBloc = getItInstance<FavoriteInterestsBloc>()
      ..add(LoadFavoriteInterests());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: _buildAppBar(context),
      bottomNavigationBar: null,
      child: _buildBody(),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return CustomAppBar(
      title: 'Favoritos',
      context: context,
      onPressedBack: () => Navigator.of(context).pop(),
    );
  }

  Widget _buildBody() {
    return CustomContainer(
      child: BlocBuilder<FavoriteInterestsBloc, FavoriteInterestsState>(
        bloc: _favoriteInterestsBloc,
        builder: (context, state) {
          if (state.isLoading!) {
            return PlaceCardItemLoading();
          }

          if (state.favoriteInterests != null &&
              state.favoriteInterests!.places!.length > 0) {
            return CategoriesPlaces(
              places: state.favoriteInterests!.places,
            );
          }

          if (state.favoriteInterests == null ||
              state.favoriteInterests?.places?.length == 0) {
            return Container(
              child: Center(
                  child: "Ops...\n não encontramos nenhum favorito"
                      .labelIntro(context)),
              height: SizeConfig.screenHeight / 1.5,
            );
          }

          if (state.isError!) {
            return Container(
              child: Center(
                  child: "Ops... houve um erro.\nTente novamente"
                      .labelIntro(context)),
              height: SizeConfig.screenHeight / 1.5,
            );
          }

          return SizedBox.shrink();
        },
      ),
    );
  }
}
