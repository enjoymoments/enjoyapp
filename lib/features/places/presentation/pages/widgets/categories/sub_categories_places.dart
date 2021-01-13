import 'package:flutter/material.dart';
import 'package:mozin/features/places/data/models/places_sub_category_model.dart';
import 'package:mozin/features/places/presentation/pages/widgets/categories/cubit/categories_places_cubit.dart';
import 'package:mozin/modules/config/size_config.dart';
import 'package:mozin/package_view/custom_border.dart';

class SubCategoriesPlaces extends StatefulWidget {
  const SubCategoriesPlaces({
    Key key,
    @required this.subCategories,
    @required this.tabstitle,
    @required this.categoriesPlacesCubit,
  }) : super(key: key);

  final List<PlacesSubCategoryModel> subCategories;
  final List<Widget> tabstitle;
  final CategoriesPlacesCubit categoriesPlacesCubit;

  @override
  _SubCategoriesPlacesState createState() => _SubCategoriesPlacesState();
}

class _SubCategoriesPlacesState extends State<SubCategoriesPlaces>
    with TickerProviderStateMixin {
  TabController _nestedTabController;

  @override
  void initState() {
    _nestedTabController =
        new TabController(length: widget.subCategories.length, vsync: this);

    _nestedTabController.addListener(_handleTabSelection);
    super.initState();
  }

  @override
  void dispose() {
    _nestedTabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _buildTabs();
  }

  Widget _buildTabs() {
    return CustomBorder(
      height: SizeConfig.sizeByPixel(34),
      child: Center(
        child: TabBar(
          controller: _nestedTabController,
          indicatorColor: Theme.of(context).primaryColor,
          labelColor: Theme.of(context).primaryColor,
          unselectedLabelColor: Theme.of(context).iconTheme.color,
          isScrollable: true,
          tabs: widget.tabstitle,
        ),
      ),
    );
  }

  void _handleTabSelection() {
    if (_nestedTabController.indexIsChanging) {
      widget.categoriesPlacesCubit.subCategorySelected(widget.subCategories[_nestedTabController.index].data);
    }
  }
}
