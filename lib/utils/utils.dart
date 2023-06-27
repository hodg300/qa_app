class Utils{
  static bool? _isInDebugMode = true;

  static bool get isInReleaseMode => !isInDebugMode;

  static bool get isInDebugMode {
    if (_isInDebugMode == null) {
      _isInDebugMode = false;
      // From: https://stackoverflow.com/questions/49707028/check-if-running-app-is-in-debug-mode
      assert(_isInDebugMode = true); // Because assert runs only in debug mode.
    }

    return _isInDebugMode!;
  }
}