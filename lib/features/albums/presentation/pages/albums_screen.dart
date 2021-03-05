import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mozin/features/albums/presentation/blocs/albums/albums_cubit.dart';
import 'package:mozin/modules/config/router.gr.dart';
import 'package:mozin/modules/config/setup.dart';
import 'package:mozin/package_view/AppIcons.dart';
import 'package:mozin/package_view/custom_app_bar.dart';
import 'package:mozin/package_view/custom_circular_progress_indicador.dart';
import 'package:mozin/package_view/custom_container.dart';
import 'package:mozin/package_view/custom_icon.dart';
import 'package:mozin/package_view/custom_scaffold.dart';
import 'package:mozin/package_view/extension.dart';

class AlbumsScreen extends StatefulWidget {
  @override
  _AlbumsScreenState createState() => _AlbumsScreenState();
}

class _AlbumsScreenState extends State<AlbumsScreen> {
  AlbumsCubit _albumsCubit;

  @override
  void initState() {
    _albumsCubit = getItInstance<AlbumsCubit>();

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

        if (state.isSuccess) {
          //getItInstance<TimelineBloc>()..add(LoadPosts());
          ExtendedNavigator.of(context).pop();
        }
      },
      builder: (context, state) {
        if (state.isLoading) {
          return CustomCircularProgressIndicator();
        }

        // if (state.images != null && state.images.length > 0) {
        //   _images = state.images;
        //   return _buildContent(
        //     ImageItems(
        //       addTimeLineBloc: _addTimeLineBloc,
        //       images: state.images,
        //     ),
        //   );
        // }

        return _buildEmpty();
      },
    );
  }

  Widget _buildEmpty() {
    return CustomContainer(
      child: Center(
        child: "Opa... vamos adicionar o primeiro álbum ?".labelIntro(context),
      ),
    );
  }

  Widget _buildContent() {
    return SingleChildScrollView(
      child: CustomContainer(
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
