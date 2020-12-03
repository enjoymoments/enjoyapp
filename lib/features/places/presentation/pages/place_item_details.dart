import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mozin/features/places/data/models/place_model.dart';
import 'package:mozin/features/places/domain/enums/place_detail_tabs_enum.dart';
import 'package:mozin/features/places/presentation/blocs/place_details/place_details_bloc.dart';
import 'package:mozin/features/places/presentation/pages/widgets/rating_item.dart';
import 'package:mozin/features/places/presentation/pages/widgets/tabs/general/general_tab_item.dart';
import 'package:mozin/features/places/presentation/pages/widgets/tabs/photos/photos_tab_item.dart';
import 'package:mozin/features/places/presentation/pages/widgets/tabs/rating/rating_tab_item.dart';
import 'package:mozin/modules/config/setup.dart';
import 'package:mozin/modules/config/size_config.dart';
import 'package:mozin/package_view/custom_app_bar.dart';
import 'package:mozin/package_view/custom_border.dart';
import 'package:mozin/package_view/custom_container.dart';
import 'package:mozin/package_view/custom_scaffold.dart';
import 'package:mozin/package_view/extension.dart';
import 'package:mozin/package_view/spacer_box.dart';

//TODO:in development

class PlaceItemDetails extends StatefulWidget {
  final PlaceModel item;

  PlaceItemDetails({Key key, @required this.item}) : super(key: key);

  @override
  _PlaceItemDetailsState createState() => _PlaceItemDetailsState();
}

class _PlaceItemDetailsState extends State<PlaceItemDetails>
    with TickerProviderStateMixin {
  final List<String> _imgList = [
    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
    'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
    'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
  ];

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

  TabController _nestedTabController;
  PlaceDetailsBloc _placeDetailsBloc;

  @override
  void initState() {
    super.initState();

    _placeDetailsBloc = getItInstance<PlaceDetailsBloc>();
    _nestedTabController =
        new TabController(length: _tabsTitle.length, vsync: this);

    _nestedTabController.addListener(_handleTabSelection);
  }

  @override
  void dispose() {
    super.dispose();
    _nestedTabController.dispose();
    _placeDetailsBloc.close();
  }

  _handleTabSelection() {
    if (_nestedTabController.indexIsChanging) {
      _placeDetailsBloc.add(ChangeTabEvent(_nestedTabController.index));
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
            _buildCarousel(),
            SpacerBox.v8,
            "Gelato".title(context),
            SpacerBox.v8,
            RatingItem(
              mainAxisAlignment: MainAxisAlignment.start,
              item: widget.item,
            ),
            SpacerBox.v8,
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
                ),
              ),
            ),
            SpacerBox.v8,
            _buildContent(),
          ],
        ),
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

  Widget _buildContent() {
    return BlocBuilder<PlaceDetailsBloc, PlaceDetailsState>(
      cubit: _placeDetailsBloc,
      builder: (context, state) {
        if (state.currentTab == PlaceDetailTabsEnum.general) {
          return GeneralTabItem();
        } else if (state.currentTab == PlaceDetailTabsEnum.rating) {
          return RatingTabItem(
            item: widget.item,
          );
        } else if (state.currentTab == PlaceDetailTabsEnum.photo) {
          return PhotosTabItem();
        }

        return SizedBox.shrink();
      },
    );
  }

  Widget _buildCarousel() {
    return CarouselSlider(
      options: CarouselOptions(
        aspectRatio: 2.0,
        enlargeCenterPage: true,
        enableInfiniteScroll: false,
        initialPage: 2,
      ),
      items: _buildPhotos(),
    );
  }

  List<Widget> _buildPhotos() {
    return _imgList
        .map(
          (item) => Container(
            child: Container(
              margin: EdgeInsets.all(5.0),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                child: Stack(
                  children: <Widget>[
                    Image.network(item, fit: BoxFit.cover, width: 1000.0),
                  ],
                ),
              ),
            ),
          ),
        )
        .toList();
  }
}
