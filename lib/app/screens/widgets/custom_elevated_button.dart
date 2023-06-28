import 'package:flutter/material.dart';

import '../../../utils/colors.dart';
import '../../../utils/utils.dart';

class CustomElevatedButton extends StatelessWidget {
  CustomElevatedButton(
      {required Key key,
      required this.child,
      this.color = Colors.indigo,
      this.borderRadius = 8.0,
      this.height = 50.0,
      this.minWidth,
      this.onPressed,
      this.roundedRectangleBorder,
      this.padding = const EdgeInsets.fromLTRB(40.0, 18.0, 40.0, 18.0),
      this.borderSide,
      this.shadowColor,
      this.elevatedPadding,
      this.spreadRadius,
      this.offsetBoxShadow,
      this.delayedInMilli = 70,
      this.onSurfaceColor,
      this.blurRadius})
      : assert(borderRadius != null);
  final Widget child;
  final Color color;
  final double borderRadius;
  final double height;
  final double? minWidth;
  final VoidCallback? onPressed;
  final EdgeInsetsGeometry padding;
  final RoundedRectangleBorder? roundedRectangleBorder;
  final BorderSide? borderSide;
  final Color? shadowColor;
  final EdgeInsetsGeometry? elevatedPadding;
  final double? spreadRadius;
  final Offset? offsetBoxShadow;
  final int delayedInMilli;
  final Color? onSurfaceColor;
  final double? blurRadius;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        key: key,
        height: height,
        width: minWidth ?? Utils.screenWidthSize(context) * 0.7,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(borderRadius),
            ),
            boxShadow: [
              BoxShadow(
                color: shadowColor ?? grey180,
                spreadRadius: spreadRadius ?? 1,
                blurRadius: blurRadius ?? 3,
                offset: offsetBoxShadow ?? Offset(0, 0),
              ),
              // BoxShadow(
              //   color: shadowColor,
              //   spreadRadius: -1.0,
              //   blurRadius: 12.0,
              // ),
            ]),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            side: borderSide,
            padding: elevatedPadding,
            shape: roundedRectangleBorder ?? RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(borderRadius)),
            primary: color,
            onSurface: onSurfaceColor,
            shadowColor: Colors.transparent,
            elevation: 20,
            animationDuration: Duration(milliseconds: delayedInMilli),
          ),
          onPressed: onPressed,
          child: Padding(padding: padding, child: child),
        ),
      ),
    );
  }
}
