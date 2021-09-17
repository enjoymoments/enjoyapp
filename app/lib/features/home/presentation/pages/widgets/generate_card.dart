import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mozin/features/home/presentation/pages/widgets/card_container.dart';
import 'package:mozin/features/home/presentation/pages/widgets/card_content.dart';

class GenerateCard extends StatelessWidget {
  final IconData iconData;
  final String routeName;
  final String name;
  final String description;

  const GenerateCard({
    Key? key,
    required this.iconData,
    required this.routeName,
    required this.name,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AutoRouter.of(context).pushNamed(routeName);
      },
      child: CardContainer(
        child: CardContent(
          iconData: iconData,
          name: name,
          description: description,
        ),
      ),
    );
  }
}
