import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:mozin/features/favoriteinterests/presentation/bloc/favorite_interests_bloc.dart';
import 'package:mozin/features/favoriteinterests/presentation/bloc/favorite_interests_event.dart';
import 'package:mozin/features/favoriteinterests/presentation/bloc/favorite_interests_state.dart';
import 'package:mozin/features/suggestions/data/models/suggestions_model.dart';
import 'package:mozin/features/suggestions/presentation/bloc/suggestions_cubit.dart';
import 'package:custom_view/size_config.dart';
import 'package:custom_view/AppIcons.dart';
import 'package:custom_view/custom_font_size.dart';
import 'package:custom_view/custom_icon.dart';
import 'package:mozin/modules/shared/custom_view_migrate/custom_item_modal_fit.dart';
import 'package:mozin/modules/shared/custom_view_migrate/custom_modal_fit.dart';
import 'package:custom_view/extensions/extension.dart';
import 'package:custom_view/spacer_box.dart';

class SuggestionItem extends StatelessWidget {
  const SuggestionItem({
    Key key,
    @required this.item,
    @required this.suggestionsCubit,
    @required this.favoriteInterestsBloc,
  }) : super(key: key);

  final SuggestionsModel item;
  final SuggestionsCubit suggestionsCubit;
  final FavoriteInterestsBloc favoriteInterestsBloc;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: myBoxDecoration(context),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: item.title.title(context)),
              _buildOptions(context),
            ],
          ),
          SpacerBox.v8,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: item.description.description(context)),
            ],
          ),
          SpacerBox.v8,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildFavorite(context),
              Row(
                children: [
                  _buildLike(context),
                  SpacerBox.h43,
                  _buildDislike(context),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  BoxDecoration myBoxDecoration(BuildContext context) {
    return BoxDecoration(
      border: Border.all(color: Theme.of(context).hintColor),
      borderRadius: BorderRadius.all(Radius.circular(5.0)),
    );
  }

  Widget _buildFavorite(BuildContext context) {
    return BlocBuilder<FavoriteInterestsBloc, FavoriteInterestsState>(
      cubit: favoriteInterestsBloc,
      builder: (context, state) {
        return IconButton(
          padding: const EdgeInsets.all(0),
          icon: CustomIcon(
              icon: AppIcons.bookmark,
              color: state.favoriteAdded
                  ? Theme.of(context).accentIconTheme.color
                  : Theme.of(context).iconTheme.color),
          onPressed: () {
            favoriteInterestsBloc.add(AddSuggestionToFavorite(item));
          },
        );
      },
    );
  }

  Widget _buildOptions(BuildContext context) {
    if (!item.moreOptionsEnable) {
      return SizedBox.shrink();
    }

    return InkWell(
      onTap: () {
        showMaterialModalBottomSheet(
          context: context,
          builder: (context) => CustomModalFit(
            items: [
              CustomItemModalFit(
                text: 'Deletar',
                iconData: AppIcons.trash,
                onTap: () {
                  confirmRemove(context);
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

  Widget _buildLike(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Row(
        children: [
          CustomIcon(
            icon: AppIcons.thumbs_up,
            size: CustomFontSize.f16,
          ),
          SpacerBox.h5,
          item.like.toString().label(context, fontSize: CustomFontSize.f16),
        ],
      ),
    );
  }

  Widget _buildDislike(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Row(
        children: [
          CustomIcon(
            icon: AppIcons.thumbs_down,
            size: CustomFontSize.f16,
          ),
          SpacerBox.h5,
          item.dislike.toString().label(context, fontSize: CustomFontSize.f16),
        ],
      ),
    );
  }

  void confirmRemove(BuildContext context) {
    showMaterialModalBottomSheet(
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
              suggestionsCubit.remove(item.id);
            },
          ),
        ],
      ),
    );
  }
}
