import 'package:flutter/material.dart';

class CustomTextbutton extends StatelessWidget {
  final Icon? icon;
  final String textOnBtn;
  final double fontSize;
  final FontWeight fontWeight;
  final Color iconColor;
  final double iconSize;
  final double spacing;
  final Color fgColor;
  final List<Color> bgColor;
  final VoidCallback? onPressed;
  final double conerRadius;
  final bool outLined;
  final double bordWidth;
  final bool shadowOff;
  final bool textBtnOnly;

  final bool? floatingButton;
  final String heroTag;
  final String tooltip;
  final bool mini;

  const CustomTextbutton({
    super.key,
    this.icon,
    this.onPressed,
    this.floatingButton,
    this.textBtnOnly = false,
    this.shadowOff = true,
    this.textOnBtn = "Click me",
    this.fontSize = 16,
    this.fontWeight = FontWeight.w600,
    this.iconColor = Colors.red,
    this.iconSize = 32,
    this.spacing = 8,
    this.bgColor = const [Colors.black],
    this.fgColor = Colors.white,
    this.conerRadius = 12,
    this.outLined = false,
    this.bordWidth = 1.2,
    this.tooltip = "Add",
    this.heroTag = "iiii",
    this.mini = false,
  });

  void _handleButton(BuildContext context) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 1),
        // action: SnackBarAction(label: "Close", onPressed: (){ScaffoldMessenger.of(context).hideCurrentSnackBar();}),
        content: Text(
          "Currently, this is in under developement.",
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    if (floatingButton == true) {
      return FloatingActionButton(
        onPressed: onPressed ?? () { _handleButton(context); },
        heroTag: heroTag,
        tooltip: tooltip,
        mini: mini,
        shape: const CircleBorder(),
        backgroundColor: bgColor.first,
        child: Icon(icon?.icon, color: iconColor, size: iconSize,),
      );
    }

    if (textBtnOnly) {
      return TextButton(
        onPressed: onPressed ?? () { _handleButton(context); },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon!.icon, color: iconColor, size: iconSize),
              SizedBox(width: spacing),
            ],
            Text(
              textOnBtn,
              style: TextStyle(
                color: fgColor,
                fontSize: fontSize,
                fontWeight: fontWeight,
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(conerRadius),
        border: outLined
            ? Border.all(width: bordWidth, color: bgColor.first)
            : null,
        gradient: outLined
            ? null
            : LinearGradient(
                colors: bgColor.length == 1
                    ? [bgColor.first, bgColor.first]
                    : bgColor,
              ),
        boxShadow: shadowOff
            ? null
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
      ),
      child: TextButton(
        onPressed: onPressed ?? () { _handleButton(context); },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon!.icon, color: iconColor, size: iconSize),
              SizedBox(width: spacing),
            ],
            Text(
              textOnBtn,
              style: TextStyle(
                color: fgColor,
                fontSize: fontSize,
                fontWeight: fontWeight,
              ),
            ),
          ],
        ),
      ),
    );
  }

}
