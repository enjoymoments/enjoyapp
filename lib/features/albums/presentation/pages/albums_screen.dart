import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mozin/features/albums/data/models/album_item_model.dart';
import 'package:mozin/features/albums/presentation/blocs/albums/albums_cubit.dart';
import 'package:mozin/features/albums/presentation/pages/widgets/albums_loading.dart';
import 'package:mozin/modules/config/router.gr.dart';
import 'package:mozin/modules/config/setup.dart';
import 'package:mozin/modules/config/size_config.dart';
import 'package:mozin/package_view/AppIcons.dart';
import 'package:mozin/package_view/custom_app_bar.dart';
import 'package:mozin/package_view/custom_container.dart';
import 'package:mozin/package_view/custom_icon.dart';
import 'package:mozin/package_view/custom_scaffold.dart';
import 'package:mozin/package_view/extension.dart';
import 'package:mozin/package_view/spacer_box.dart';

class AlbumsScreen extends StatefulWidget {
  @override
  _AlbumsScreenState createState() => _AlbumsScreenState();
}

class _AlbumsScreenState extends State<AlbumsScreen> {
  AlbumsCubit _albumsCubit;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    _albumsCubit = getItInstance<AlbumsCubit>()..mapGetAllAlbums();

    super.initState();
  }

  @override
  void dispose() {
    _albumsCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: _buildBody(),
      appBar: _buildAppBar(),
      bottomNavigationBar: null,
    );
  }

  Widget _buildAppBar() {
    return CustomAppBar(
      title: 'Todos os álbums',
      iconColors: Theme.of(context).backgroundColor,
      onPressedBack: () {
        Navigator.of(context).pop();
      },
      actions: <Widget>[
        IconButton(
          icon: CustomIcon(icon: AppIcons.plus),
          onPressed: () {
            ExtendedNavigator.of(context).push(Routes.add_albums_screen);
          },
        ),
      ],
    );
  }

  Widget _buildBody() {
    return BlocConsumer<AlbumsCubit, AlbumsState>(
      cubit: _albumsCubit,
      listener: (consumerContext, state) {
        if (state.isError) {
          consumerContext.showSnackBar(
              state.errorMessage ?? 'Ops, houve um erro. Tente novamente');
        }
      },
      builder: (context, state) {
        if (state.isLoading) {
          return AlbumsLoading();
        }

        if (state.albums != null && state.albums.length > 0) {
          return CustomContainer(
            child: _buildAlbums(state),
          );
        }

        return _buildEmpty();
      },
    );
  }

  Widget _buildEmpty() {
    return Center(
      child: "Opa... vamos adicionar o primeiro álbum ?".labelIntro(context),
    );
  }

  Widget _buildAlbums(AlbumsState state) {
    return RefreshIndicator(
      key: _refreshIndicatorKey,
      color: Theme.of(context).primaryColor,
      onRefresh: () async {
        _albumsCubit.mapGetAllAlbums();
      },
      child: ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        separatorBuilder: (context, index) => SpacerBox.v16,
        itemCount: state.albums.length,
        itemBuilder: (context, index) => _buildAlbumItem(state.albums[index]),
      ),
    );
  }

  Widget _buildAlbumItem(AlbumItemModel album) {
    return GestureDetector(
      onTap: () {
        ExtendedNavigator.of(context).push(Routes.add_albums_screen, arguments: AddAlbumsScreenArguments(album: album));
      },
      child: CachedNetworkImage(
        imageUrl: album.medias[0].url,
        fit: BoxFit.cover,
        imageBuilder: (context, imageProvider) {
          return Container(
            child: Align(
              alignment: Alignment.center,
              child: album.titleAlbum.labelIntro(context,
                  color: Theme.of(context).backgroundColor),
            ),
            height: SizeConfig.sizeByPixel(150),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Theme.of(context).hintColor),
              image: DecorationImage(
                //TODO:review this - maybe use a another image for opacity
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.2),
                  BlendMode.darken,
                ),
                image: imageProvider,
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}
