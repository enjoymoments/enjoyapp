import 'dart:typed_data';

import 'package:auto_route/auto_route.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mozin/features/favoriteinterests/presentation/bloc/favorite_interests_item/favorite_interests_item_bloc.dart';
import 'package:mozin/features/favoriteinterests/presentation/bloc/favorite_interests_item/favorite_interests_item_event.dart';
import 'package:mozin/features/favoriteinterests/presentation/bloc/favorite_interests_item/favorite_interests_item_state.dart';
import 'package:mozin/features/places/data/models/place_model.dart';
import 'package:mozin/features/places/domain/enums/place_detail_tabs_enum.dart';
import 'package:mozin/features/places/presentation/blocs/place_details/place_details_bloc.dart';
import 'package:mozin/features/places/presentation/blocs/place_details_tab/place_details_tab_bloc.dart';
import 'package:mozin/features/places/presentation/blocs/place_details_tab/place_details_tab_event.dart';
import 'package:mozin/features/places/presentation/blocs/place_details_tab/place_details_tab_state.dart';
import 'package:mozin/features/places/presentation/blocs/place_photos/place_photos_bloc.dart';
import 'package:mozin/features/places/presentation/pages/widgets/load_photos_in_memory.dart';
import 'package:mozin/features/places/presentation/pages/widgets/rating_item.dart';
import 'package:mozin/features/places/presentation/pages/widgets/tabs/general/general_tab_item.dart';
import 'package:mozin/features/places/presentation/pages/widgets/tabs/general/widgets/gps_open/cubit/gpsopen_cubit.dart';
import 'package:mozin/features/places/presentation/pages/widgets/tabs/photos/photos_tab_item.dart';
import 'package:mozin/features/places/presentation/pages/widgets/tabs/rating/rating_tab_item.dart';
import 'package:mozin/modules/config/setup.dart';
import 'package:custom_view/size_config.dart';
import 'package:mozin/modules/shared/general/models/user_app_model.dart';
import 'package:mozin/modules/shared/general/models/user_wrapper.dart';
import 'package:custom_view/AppIcons.dart';
import 'package:custom_view/custom_app_bar.dart';
import 'package:custom_view/custom_border.dart';
import 'package:custom_view/custom_container.dart';
import 'package:custom_view/custom_font_size.dart';
import 'package:custom_view/custom_icon.dart';
import 'package:custom_view/custom_scaffold.dart';
import 'package:custom_view/extensions/extension.dart';
import 'package:custom_view/shimmer_loading.dart';
import 'package:custom_view/spacer_box.dart';

class PlaceItemDetails extends StatefulWidget {
  final PlaceModel? item;

  PlaceItemDetails({Key? key, required this.item}) : super(key: key);

  @override
  _PlaceItemDetailsState createState() => _PlaceItemDetailsState();
}

class _PlaceItemDetailsState extends State<PlaceItemDetails>
    with TickerProviderStateMixin {
  List<Widget> _tabsTitle = [
    Tab(
      text: "Geral",
    ),
    Tab(
      text: "Avaliações",
    ),
    Tab(
      text: "Fotos",
    ),
  ];

  TabController? _nestedTabController;
  PlaceDetailsTabBloc? _placeDetailsTabBloc;
  PlaceDetailsBloc? _placeDetailsBloc;
  PlacePhotosBloc? _placePhotosBloc;
  GpsOpenCubit? _gpsOpenCubit;
  FavoriteInterestsItemBloc? _favoriteInterestsItemBloc;
  UserAppModel? _user;

  @override
  void initState() {
    super.initState();

    _user = getItInstance<UserWrapper>().getUser;
    _favoriteInterestsItemBloc = getItInstance<FavoriteInterestsItemBloc>();
    _placeDetailsTabBloc = getItInstance<PlaceDetailsTabBloc>();
    _placePhotosBloc = getItInstance<PlacePhotosBloc>();
    _placeDetailsBloc = getItInstance<PlaceDetailsBloc>()
      ..add(LoadDetails(widget.item, _favoriteInterestsItemBloc, _placePhotosBloc));

    _gpsOpenCubit = getItInstance<GpsOpenCubit>()
      ..getElements(
        context,
        widget.item!.name,
        widget.item!.formattedAddress,
        widget.item!.location!.latitude,
        widget.item!.location!.longitude,
      );

    _nestedTabController =
        new TabController(length: _tabsTitle.length, vsync: this);

    _nestedTabController!.addListener(_handleTabSelection);
  }

  @override
  void dispose() {
    super.dispose();
    _nestedTabController!.dispose();
    _placeDetailsTabBloc!.close();
    _placeDetailsBloc!.close();
    _placePhotosBloc!.close();
    _gpsOpenCubit!.close();
    _favoriteInterestsItemBloc!.close();
  }

  _handleTabSelection() {
    if (_nestedTabController!.indexIsChanging) {
      _placeDetailsTabBloc!.add(ChangeTabEvent(_nestedTabController!.index));
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return CustomScaffold(
      child: _buildBody(context),
      appBar: _buildAppBar(context),
      bottomNavigationBar: null,
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: CustomContainer(
        child: Column(
          children: [
            BlocListener<FavoriteInterestsItemBloc, FavoriteInterestsItemState>(
              bloc: _favoriteInterestsItemBloc,
              listener: (context, state) {
                if (state.isError!) {
                  context.showSnackBar('Ops... houve um erro. Tente novamente');
                }
              },
              child: SizedBox.shrink(),
            ),
            BlocBuilder<PlacePhotosBloc, PlacePhotosState>(
              bloc: _placePhotosBloc,
              builder: (context, state) {
                if (state.isLoading!) {
                  return _buildLoadingPhotos();
                } else if (state.item?.photos != null) {
                  return _buildCarousel(state.item!.photos!);
                }

                return _buildLoadingPhotos();
              },
            ),
            SpacerBox.v8,
            BlocBuilder<PlaceDetailsBloc, PlaceDetailsState>(
              bloc: _placeDetailsBloc,
              builder: (context, state) {
                if (state.isLoading!) {
                  return _buildLoadingContent();
                } else if (state.item != null) {
                  return _buildContent();
                }

                return _buildLoadingContent();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingPhotos() {
    return CarouselSlider(
      options: CarouselOptions(
        aspectRatio: 2.0,
        enlargeCenterPage: true,
        enableInfiniteScroll: false,
        initialPage: 2,
      ),
      items: [0, 1, 2]
          .map(
            (item) => Container(
              child: Container(
                margin: EdgeInsets.all(5.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  child: ShimmerLoading(
                    width: SizeConfig.sizeByPixel(300),
                    height: SizeConfig.sizeByPixel(20),
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildLoadingContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SpacerBox.v8,
        ShimmerLoading(
          width: SizeConfig.sizeByPixel(SizeConfig.screenWidth!),
          height: SizeConfig.sizeByPixel(30),
        ),
        SpacerBox.v4,
        Row(
          children: [
            ShimmerLoading(
              width: SizeConfig.sizeByPixel(50),
              height: SizeConfig.sizeByPixel(20),
            ),
            SpacerBox.h8,
            ShimmerLoading(
              width: SizeConfig.sizeByPixel(50),
              height: SizeConfig.sizeByPixel(20),
            ),
          ],
        ),
        SpacerBox.v16,
        ShimmerLoading(
          width: SizeConfig.sizeByPixel(SizeConfig.screenWidth!),
          height: SizeConfig.sizeByPixel(34),
        ),
        SpacerBox.v16,
        ShimmerLoading(
          width: SizeConfig.sizeByPixel(SizeConfig.screenWidth!),
          height: SizeConfig.sizeByPixel(80),
        ),
        SpacerBox.v16,
        ShimmerLoading(
          width: SizeConfig.sizeByPixel(SizeConfig.screenWidth!),
          height: SizeConfig.sizeByPixel(80),
        ),
        SpacerBox.v16,
        ShimmerLoading(
          width: SizeConfig.sizeByPixel(SizeConfig.screenWidth!),
          height: SizeConfig.sizeByPixel(50),
        ),
      ],
    );
  }

  Widget _buildContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.item!.name!.title(context),
        SpacerBox.v4,
        RatingItem(
          mainAxisAlignment: MainAxisAlignment.start,
          item: widget.item,
        ),
        SpacerBox.v16,
        CustomBorder(
          height: SizeConfig.sizeByPixel(34),
          child: Center(
            child: TabBar(
              controller: _nestedTabController,
              indicatorColor: Theme.of(context).primaryColor,
              labelColor: Theme.of(context).primaryColor,
              unselectedLabelColor: Theme.of(context).iconTheme.color,
              isScrollable: true,
              tabs: _tabsTitle,
              labelStyle: TextStyle(fontSize: CustomFontSize.f16),
            ),
          ),
        ),
        SpacerBox.v8,
        _buildContentTab(),
      ],
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return CustomAppBar(
      title: 'Sugestões',
      context: context,
      onPressedBack: () => Navigator.of(context).pop(),
      actions: [
        _buildIconStar(),
      ],
    );
  }

  Widget _buildIconStar() {
    if (_user != UserAppModel.empty()) {
      return BlocBuilder<FavoriteInterestsItemBloc, FavoriteInterestsItemState>(
        bloc: _favoriteInterestsItemBloc,
        builder: (context, state) {
          return IconButton(
            icon: CustomIcon(
                icon: AppIcons.bookmark,
                color: state.favoriteAdded!
                    ? Theme.of(context).accentIconTheme.color
                    : Theme.of(context).appBarTheme.iconTheme!.color),
            onPressed: () {
              _favoriteInterestsItemBloc!.add(AddPlaceToFavorite(widget.item));
            },
          );
        },
      );
    }

    return SizedBox.shrink();
  }

  Widget _buildContentTab() {
    return BlocBuilder<PlaceDetailsTabBloc, PlaceDetailsTabState>(
      bloc: _placeDetailsTabBloc,
      builder: (context, state) {
        if (state.currentTab == PlaceDetailTabsEnum.general) {
          return GeneralTabItem(
            item: widget.item,
            gpsOpenCubit: _gpsOpenCubit,
          );
        } else if (state.currentTab == PlaceDetailTabsEnum.rating) {
          return RatingTabItem(
            item: widget.item,
          );
        } else if (state.currentTab == PlaceDetailTabsEnum.photo) {
          return PhotosTabItem(
            placePhotosBloc: _placePhotosBloc,
          );
        }

        return SizedBox.shrink();
      },
    );
  }

  Widget _buildCarousel(List<Uint8List> images) {
    return CarouselSlider(
      options: CarouselOptions(
        aspectRatio: 2.0,
        enlargeCenterPage: true,
        enableInfiniteScroll: false,
        initialPage: 2,
      ),
      items: buildPhotos(context, images, SizeConfig.sizeByPixel(1000)),
    );
  }
}
