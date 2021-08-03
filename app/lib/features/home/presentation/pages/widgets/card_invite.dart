import 'package:flutter/material.dart';
import 'package:mozin/features/home/presentation/pages/widgets/card_content.dart';
import 'package:custom_view/size_config.dart';
import 'package:custom_view/AppIcons.dart';

class CardInvite extends StatelessWidget {
  const CardInvite({
    Key key,
    @required this.isLoading,
  }) : super(key: key);

  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return _buildLoading();
    }

    return _buildState();
  }

  Widget _buildLoading() {
    return ButtonTheme(
      child: IconButton(
        padding: EdgeInsets.all(0),
        icon: SizedBox(
          height: SizeConfig.sizeByPixel(24.0),
          width: SizeConfig.sizeByPixel(24.0),
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            strokeWidth: SizeConfig.sizeByPixel(2.0),
          ),
        ),
        onPressed: null,
      ),
    );
  }

  Widget _buildState() {
    return CardContent(
      iconData: AppIcons.paper_plane,
      name: 'Convidar meu par',
      description: 'O que pretende fazer nos próximos dias ?',
    );
  }
}
