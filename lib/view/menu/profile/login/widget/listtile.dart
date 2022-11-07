import 'package:flutter/material.dart';

class TileInfo extends StatelessWidget {
  TileInfo({
    super.key,
    required this.text,
    required this.icon,
    required this.bgTile,
    this.onTap,
  });

  String text;
  Icon icon;
  Color bgTile;
  VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(text),
      leading: CircleAvatar(
        backgroundColor: bgTile,
        radius: kRadialReactionRadius,
        child: icon,
      ),
      onTap: onTap,
    );
  }
}
