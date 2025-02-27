import 'package:flutter/material.dart';
import '../../theme/theme.dart';

enum BlaButtonType {
  primary,
  secondary
}

class BlaButton extends StatelessWidget {
  final String text;
  final BlaButtonType type;
  final VoidCallback? onPressed;
  final IconData? leftIcon;

  const BlaButton({
    super.key,
    required this.text,
    this.type = BlaButtonType.primary,
    this.onPressed,
    this.leftIcon,
  });

  @override
  Widget build(BuildContext context) {
    final isPrimary = type == BlaButtonType.primary;
    
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isPrimary ? BlaColors.primary : BlaColors.white,
        foregroundColor: isPrimary ? BlaColors.white : BlaColors.primary,
        disabledBackgroundColor: isPrimary ? BlaColors.primary.withOpacity(0.5) : BlaColors.white,
        disabledForegroundColor: isPrimary ? BlaColors.white.withOpacity(0.5) : BlaColors.primary.withOpacity(0.5),
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: type == BlaButtonType.secondary 
              ? BorderSide(color: BlaColors.primary)
              : BorderSide.none,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (leftIcon != null) ...[
            Icon(leftIcon),
            const SizedBox(width: 8),
          ],
          Text(
            text,
            style: BlaTextStyles.button,
          ),
        ],
      ),
    );
  }
}