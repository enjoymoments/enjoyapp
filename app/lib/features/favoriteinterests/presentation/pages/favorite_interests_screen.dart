import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mozin/features/favoriteinterests/presentation/bloc/favorite_interests_bloc.dart';
import 'package:mozin/features/favoriteinterests/presentation/bloc/favorite_interests_event.dart';
import 'package:mozin/features/favoriteinterests/presentation/bloc/favorite_interests_state.dart';
import 'package:mozin/features/places/presentation/pages/widgets/categories/categories_places.dart';
import 'package:mozin/features/places/presentation/pages/widgets/loadings/place_card_item_loading.dart';
import 'package:mozin/modules/config/setup.dart';
import 'package:mozin/modules/config/size_config.dart';
import 'package:mozin/package_view/custom_app_bar.dart';
import 'package:mozin/package_view/custom_container.dart';
import 'package:mozin/package_view/custom_scaffold.dart';
import 'package:mozin/package_view/extension.dart';

class FavoriteInterestsScreen extends StatefulWidget {
  @override
  _FavoriteInterestsScreenState createState() => _FavoriteInterestsScreenState();
}

class _FavoriteInterestsScreenState extends State<FavoriteInterestsScreen> {
  FavoriteInterestsBloc _favoriteInterestsBloc;

  @override
  void initState() {
    _favoriteInterestsBloc = getItInstance<FavoriteInterestsBloc>()
      ..add(LoadFavoriteInterests());
    super.initState();
  }

  @override
  void dispose() {
    _favoriteInterestsBloc.close();
    super.dispose();
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
      child: BlocBuilder<FavoriteInterestsBloc, FavoriteInterestsState>(
        cubit: _favoriteInterestsBloc,
        builder: (context, state) {
          if (state.isLoading) {
            return PlaceCardItemLoading();
          }

          if (state.favoriteInterests != null &&
              state.favoriteInterests.places.length > 0) {
            return CategoriesPlaces(
              places: state.favoriteInterests.places,
            );
          }

          if (state.favoriteInterests == null ||
              state.favoriteInterests?.places?.length == 0) {
            return Container(
              child: Center(child: "Ops...\n não encontramos nenhum favorito".labelIntro(context)),
              height: SizeConfig.screenHeight / 1.5,
            );
          }

          if (state.isError) {
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

  AppBar _buildAppBar(BuildContext context) {
    return CustomAppBar(
      title: 'Favoritos',
      context: context,
      onPressedBack: () => Navigator.of(context).pop(),
    );
  }
}
