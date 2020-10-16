import 'package:flutter/material.dart';
import 'package:mozin/modules/config/size_config.dart';
import 'package:mozin/views/places/widgets/tabs/general/general_tab_item.dart';
import 'package:mozin/views/places/widgets/tabs/photos/photos_tab_item.dart';
import 'package:mozin/views/places/widgets/tabs/rating/rating_tab_item.dart';
import 'package:mozin/views/shared/custom_border.dart';
import 'package:mozin/views/shared/spacer_box.dart';

class BuilderTabs extends StatefulWidget {
  @override
  _BuilderTabsState createState() => _BuilderTabsState();
}

class _BuilderTabsState extends State<BuilderTabs>
    with TickerProviderStateMixin {
  TabController _nestedTabController;

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
    Tab(
      text: "Sobre",
    ),
  ];

  @override
  void initState() {
    super.initState();
    _nestedTabController =
        new TabController(length: _tabsTitle.length, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _nestedTabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
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
        Container(
          height: SizeConfig.screenHeight * 0.70,
          child: TabBarView(
            controller: _nestedTabController,
            children: <Widget>[
              GeneralTabItem(),
              RatingTabItem(),
              PhotosTabItem(),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(1.0),
                  color: Colors.black,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}