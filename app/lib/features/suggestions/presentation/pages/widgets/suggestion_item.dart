import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:mozin/features/suggestions/data/models/suggestions_model.dart';
import 'package:mozin/features/suggestions/presentation/bloc/suggestions_cubit.dart';
import 'package:mozin/modules/config/size_config.dart';
import 'package:mozin/package_view/AppIcons.dart';
import 'package:mozin/package_view/custom_font_size.dart';
import 'package:mozin/package_view/custom_icon.dart';
import 'package:mozin/package_view/custom_item_modal_fit.dart';
import 'package:mozin/package_view/custom_modal_fit.dart';
import 'package:mozin/package_view/extension.dart';
import 'package:mozin/package_view/spacer_box.dart';

class SuggestionItem extends StatelessWidget {
  const SuggestionItem({
    Key key,
    @required this.item,
    @required this.suggestionsCubit,
  }) : super(key: key);

  final SuggestionsModel item;
  final SuggestionsCubit suggestionsCubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(child: item.title.title(context)),
            _buildOptions(context),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: item.description.description(context)),
          ],
        ),
        //TODO:review this
        // SpacerBox.v8,
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.end,
        //   children: [
        //     _buildLike(context),
        //     SpacerBox.h43,
        //     _buildDislike(context),
        //   ],
        // ),
      ],
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
