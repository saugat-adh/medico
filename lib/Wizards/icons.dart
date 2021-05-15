import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class DashIcons extends StatelessWidget {
  final List<bool> isSelekted = List.generate(4, (index) => false);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ToggleButtons(
        constraints: BoxConstraints(
          maxHeight: 100,
          maxWidth: 100,
          minHeight: 80,
          minWidth: 80,
        ),
        selectedBorderColor: Colors.teal,
        renderBorder: false,
        fillColor: Colors.transparent,
        children: [
          Icon(FeatherIcons.settings),
          Icon(FeatherIcons.shoppingCart),
          Icon(FeatherIcons.bell),
          Icon(FeatherIcons.logOut),
        ],
        isSelected: isSelekted,
      ),
    );
  }
}
