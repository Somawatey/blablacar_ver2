import 'package:flutter/material.dart';
import 'package:week_3_blabla_project/theme/theme.dart';

class RidePrefList extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback? onTap;
  final Widget? trailing;

  const RidePrefList({
    super.key,
    required this.icon,
    required this.text,
    this.onTap,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.black54),
              SizedBox(width: BlaSpacings.s),
              Text(text, style: BlaTextStyles.body),
            ],
          ),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}