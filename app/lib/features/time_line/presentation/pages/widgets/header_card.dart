import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:mozin/features/time_line/presentation/pages/widgets/enum/action_header_enum.dart';
import 'package:mozin/features/time_line/data/models/time_line_model.dart';
import 'package:mozin/modules/config/size_config.dart';
import 'package:mozin/package_view/AppIcons.dart';
import 'package:mozin/package_view/custom_avatar_with_name.dart';
import 'package:mozin/package_view/custom_icon.dart';
import 'package:mozin/package_view/custom_item_modal_fit.dart';
import 'package:mozin/package_view/custom_modal_fit.dart';
import 'package:mozin/package_view/extension.dart';

class HeaderCard extends StatelessWidget {
  final Function(ActionHeaderEnum) callback;
  final TimeLineItemModel item;

  const HeaderCard({
    Key key,
    @required this.item,
    @required this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            CustomAvatarWithName(
              name: item.author.name,
              backgroundImage: _getBackgroundImage(),
              child: item.dateCreationFormatted.date(context),
            ),
            InkWell(
              onTap: () {
                showMaterialModalBottomSheet(
                  context: context,
                  builder: (context) => CustomModalFit(
                    items: [
                      CustomItemModalFit(
                        text: 'Deletar',
                        iconData: AppIcons.trash,
                        onTap: () {
                          callback(ActionHeaderEnum.DELETE);
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
            ),
          ],
        ),
      ],
    );
  }

  ImageProvider _getBackgroundImage() {
    if (item.author != null &&
        item.author.photo != null &&
        item.author.photo.isNotEmpty) {
      return NetworkImage(item.author.photo);
    }
    return null;
  }
}
