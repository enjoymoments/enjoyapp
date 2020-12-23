import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mozin/features/me/presentation/pages/widgets/connected/connected_tab_enum.dart';
import 'package:mozin/features/me/presentation/pages/widgets/connected/cubit/connected_cubit.dart';
import 'package:mozin/modules/config/setup.dart';
import 'package:mozin/modules/config/size_config.dart';
import 'package:mozin/modules/shared/general/models/user_app_model.dart';
import 'package:mozin/package_view/custom_avatar.dart';
import 'package:mozin/package_view/custom_border.dart';
import 'package:mozin/package_view/custom_container.dart';
import 'package:mozin/package_view/extension.dart';
import 'package:mozin/package_view/spacer_box.dart';

class Connected extends StatefulWidget {
  final UserAppModel user;

  const Connected({Key key, @required this.user}) : super(key: key);

  @override
  _ConnectedState createState() => _ConnectedState();
}

class _ConnectedState extends State<Connected> with TickerProviderStateMixin {
  List<Widget> _tabsTitle = [
    Tab(
      text: "Álbums",
    ),
    Tab(
      text: "Lugares",
    ),
    Tab(
      text: "Fotos",
    ),
  ];

  TabController _nestedTabController;
  ConnectedCubit _connectedCubit;

  @override
  void initState() {
    _connectedCubit = getItInstance<ConnectedCubit>();
    _nestedTabController =
        new TabController(length: _tabsTitle.length, vsync: this);

    _nestedTabController.addListener(_handleTabSelection);

    super.initState();
  }

  @override
  void dispose() {
    _connectedCubit.close();
    super.dispose();
  }

  _handleTabSelection() {
    if (_nestedTabController.indexIsChanging) {
      _connectedCubit.changeTab(_nestedTabController.index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: CustomContainer(
        child: Column(
          children: <Widget>[
            SpacerBox.v10,
            _buildHeader(),
            SpacerBox.v16,
            Divider(
              color: Theme.of(context).hintColor,
              height: SizeConfig.sizeByPixel(4),
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
                ),
              ),
            ),
            SpacerBox.v8,
            _buildContentTab(),
          ],
        ),
      ),
    );
  }

  Widget _buildContentTab() {
    return BlocBuilder<ConnectedCubit, ConnectedState>(
      cubit: _connectedCubit,
      builder: (context, state) {
        if (state.connectedTabEnum == ConnectedTabEnum.ALBUM) {
          return _buildFavouritesItem(context);
        } else if (state.connectedTabEnum == ConnectedTabEnum.PLACE) {
          return SizedBox.shrink();
        } else if (state.connectedTabEnum == ConnectedTabEnum.PHOTO) {
          return SizedBox.shrink();
        }

        return SizedBox.shrink();
      },
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        CustomAvatar(
          radius: SizeConfig.sizeByPixel(35),
        ),
        SpacerBox.h16,
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.user.name.title(context),
            SpacerBox.v10,
            _buildLineInfo(context),
          ],
        ),
      ],
    );
  }

  Widget _buildLineInfo(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildItemLineInfo(context, '438', 'Posts'),
        SpacerBox.h43,
        _buildItemLineInfo(context, '298', 'Following'),
        SpacerBox.h43,
        _buildItemLineInfo(context, '321K', 'Followers'),
      ],
    );
  }

  Widget _buildItemLineInfo(
      BuildContext context, String title, String description) {
    return Column(
      children: [
        title.title(context, fontWeight: FontWeight.bold),
        SpacerBox.v4,
        description.label(context),
      ],
    );
  }

  Widget _buildFavouritesItem(BuildContext context) {
    return CarouselSlider(
      items: _buildCards(context),
      options: CarouselOptions(
        autoPlay: false,
        viewportFraction: 0.5,
        initialPage: 1,
        enableInfiniteScroll: false,
        pageSnapping: false,
      ),
    );
  }

  List<Widget> _buildCards(BuildContext context) {
    return List.generate(5, (index) {
      return Container(
        margin: EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 0.2,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl:
                      'https://i.picsum.photos/id/237/200/300.jpg?hmac=TmmQSbShHz9CdQm0NkEjx1Dyh_Y984R9LpNrpvH2D_U',
                  width: SizeConfig.sizeByPixel(150),
                  height: SizeConfig.sizeByPixel(150),
                ),
              ),
            ),
            SpacerBox.v8,
            Padding(
              padding: EdgeInsets.only(
                  left: SizeConfig.sizeByPixel(10),
                  bottom: SizeConfig.sizeByPixel(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  "Outterwear".title(context,
                      fontWeight: FontWeight.bold, fontSize: 14),
                  '170+ items'.label(context, fontSize: 13),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
