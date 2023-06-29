import 'package:flutter/cupertino.dart';

class Utils {
  static bool? _isInDebugMode = true;

  static bool get isInReleaseMode => !isInDebugMode;

  static bool get isInDebugMode {
    if (_isInDebugMode == null) {
      _isInDebugMode = false;
      assert(_isInDebugMode = true); // Because assert runs only in debug mode.
    }

    return _isInDebugMode!;
  }

  /// return width size of device in double
  static double screenWidthSize(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  /// return height size of device in double
  static double screenHeightSize(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }
}
