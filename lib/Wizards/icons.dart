import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class DashIcons extends StatelessWidget {
  final List<bool> isSelekted = List.generate(4, (index) => false);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ToggleButtons(
        selectedBorderColor: Colors.teal,
        renderBorder: false,
        fillColor: Colors.transparent,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
            child: Icon(FeatherIcons.settings, size: 27,),
          ),
          Padding(
          padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
            child: Icon(FeatherIcons.bell, size: 27),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
            child: Icon(FeatherIcons.logOut, size: 27),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
            child: Icon(FeatherIcons.paperclip, size: 27),
          ),
        ],
        isSelected: isSelekted,
      ),
    );
  }
}
