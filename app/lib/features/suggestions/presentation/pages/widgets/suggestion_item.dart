import 'package:custom_view/custom_view.dart';
import 'package:flutter/material.dart';
import 'package:mozin/features/favoriteinterests/presentation/bloc/favorite_interests_item/favorite_interests_item_bloc.dart';
import 'package:mozin/features/favoriteinterests/presentation/bloc/favorite_interests_item/favorite_interests_item_event.dart';
import 'package:mozin/features/favoriteinterests/presentation/bloc/favorite_interests_item/favorite_interests_item_state.dart';
import 'package:mozin/features/suggestions/data/models/suggestions_model.dart';
import 'package:mozin/features/suggestions/presentation/bloc/suggestions_cubit.dart';
import 'package:custom_utilities/custom_utilities.dart';

class SuggestionItem extends StatelessWidget {
  const SuggestionItem({
    Key? key,
    required this.item,
    required this.suggestionsCubit,
    required this.favoriteInterestsItemBloc,
  }) : super(key: key);

  final SuggestionsModel item;
  final SuggestionsCubit? suggestionsCubit;
  final FavoriteInterestsItemBloc? favoriteInterestsItemBloc;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: myBoxDecoration(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: item.title!.title(context)),
              _buildOptions(context),
            ],
          ),
          SpacerBox.v8,
          _buildDescription(context),
          ..._buildUrl(context, 'URL', item.url),
          ..._buildUrl(context, "ANDROID", item.urlAndroid),
          ..._buildUrl(context, "IOS", item.urlIOS),
          SpacerBox.v8,
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _buildFavorite(context),
              //TODO:in development
              // Row(
              //   children: [
              //     _buildLike(context),
              //     SpacerBox.h43,
              //     _buildDislike(context),
              //   ],
              // ),
            ],
          ),
          SpacerBox.v8,
        ],
      ),
    );
  }

  Widget _buildDescription(BuildContext context) {
    if (item.description?.isNotEmpty ?? false) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: item.description!.description(context)),
        ],
      );
    }

    return SizedBox.shrink();
  }

  List<Widget> _buildUrl(BuildContext context, String label, String? url) {
    if (url?.isNotEmpty ?? false) {
      return [
        SpacerBox.v8,
        url!.linkTapWithLabel(
          context,
          label,
          (url) => LaunchUrlService.launchURL(url),
        ),
        SpacerBox.v8,
      ];
    }

    return [SizedBox.shrink()];
  }

  BoxDecoration myBoxDecoration(BuildContext context) {
    return BoxDecoration(
      border: Border.all(color: Theme.of(context).hintColor),
      borderRadius: BorderRadius.all(Radius.circular(5.0)),
    );
  }

  Widget _buildFavorite(BuildContext context) {
    return BlocBuilder<FavoriteInterestsItemBloc, FavoriteInterestsItemState>(
      bloc: favoriteInterestsItemBloc,
      builder: (context, state) {
        return InkWell(
          child: CustomIcon(
              icon: AppIcons.bookmark,
              size: SizeConfig.sizeByPixel(22),
              color: state.favoriteAdded!
                  ? Theme.of(context).accentIconTheme.color
                  : Theme.of(context).iconTheme.color),
          onTap: () {
            favoriteInterestsItemBloc!.add(AddSuggestionToFavorite(item));
          },
        );
      },
    );
  }

  Widget _buildOptions(BuildContext context) {
    if (!item.moreOptionsEnable! &&
        (item.urlReference == null || item.urlReference == "")) {
      return SizedBox.shrink();
    }

    return InkWell(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (context) => CustomModalFit(
            items: [
              if (item.moreOptionsEnable!)
                CustomItemModalFit(
                  text: 'Deletar',
                  iconData: AppIcons.trash,
                  onTap: () {
                    confirmRemove(context);
                  },
                ),
              if (item.urlReference?.isNotEmpty ?? false)
                CustomItemModalFit(
                  text: 'Referência',
                  iconData: AppIcons.window_maximize,
                  onTap: () {
                    LaunchUrlService.launchURL(item.urlReference!);
                  },
                ),
            ],
          ),
        );
      },
      child: Container(
        width: SizeConfig.sizeByPixel(60),
        height: SizeConfig.sizeByPixel(30),
        alignment: Alignment.centerRight,
        child: CustomIcon(icon: AppIcons.ellipsis_h),
      ),
    );
  }

  //TODO:in development
  // Widget _buildLike(BuildContext context) {
  //   return InkWell(
  //     onTap: () {},
  //     child: Row(
  //       children: [
  //         CustomIcon(
  //           icon: AppIcons.thumbs_up,
  //           size: CustomFontSize.f16,
  //         ),
  //         SpacerBox.h5,
  //         item.like.toString().label(context, fontSize: CustomFontSize.f16),
  //       ],
  //     ),
  //   );
  // }

  // Widget _buildDislike(BuildContext context) {
  //   return InkWell(
  //     onTap: () {},
  //     child: Row(
  //       children: [
  //         CustomIcon(
  //           icon: AppIcons.thumbs_down,
  //           size: CustomFontSize.f16,
  //         ),
  //         SpacerBox.h5,
  //         item.dislike.toString().label(context, fontSize: CustomFontSize.f16),
  //       ],
  //     ),
  //   );
  // }

  void confirmRemove(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => CustomModalFit(
        items: [
          CustomItemModalFit(
            text: 'Não quero deletar',
            iconData: AppIcons.ad,
            onTap: () {},
          ),
          CustomItemModalFit(
            text: 'Sim, quero deletar',
            iconData: AppIcons.trash,
            onTap: () {
              suggestionsCubit!.remove(item);
            },
          ),
        ],
      ),
    );
  }
}
