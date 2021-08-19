import 'package:custom_view/AppIcons.dart';
import 'package:custom_view/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:mozin/features/time_line/presentation/blocs/time_line_bloc/time_line_bloc.dart';
import 'package:mozin/modules/config/setup.dart';
import 'package:mozin/modules/shared/custom_view_migrate/custom_avatar.dart';
import 'package:mozin/modules/shared/custom_view_migrate/custom_item_modal_fit.dart';
import 'package:mozin/modules/shared/custom_view_migrate/custom_modal_fit.dart';

class TimeLineAvatar extends StatelessWidget {

  const TimeLineAvatar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimelineBloc, TimelineState>(
      cubit: getItInstance<TimelineBloc>(),
      builder: (context, state) {
        return InkWell(
          onTap: () {
            showMaterialModalBottomSheet(
              context: context,
              builder: (context) => CustomModalFit(
                items: [
                  CustomItemModalFit(
                    text: 'Não quero remover',
                    iconData: AppIcons.ad,
                    onTap: () {},
                  ),
                  CustomItemModalFit(
                    text: 'Sim, quero remover',
                    iconData: AppIcons.trash,
                    onTap: () {},
                  ),
                ],
              ),
            );
          },
          child: Padding(
            padding: EdgeInsets.all(SizeConfig.sizeByPixel(8)),
            child: CustomAvatar(
              backgroundImage: AssetImage('assets/images/default_avatar.png'),
            ),
          ),
        );
      },
    );
  }

}
