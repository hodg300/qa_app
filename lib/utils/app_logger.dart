import 'package:go_tech_assignment/utils/utils.dart';

class AppLogger {
  static void error(dynamic errorLogMessage,
      {bool withToast = false, bool withStackTrace = true}) {
    if (Utils.isInReleaseMode) return;
    if (errorLogMessage == null) return;

    if (withStackTrace) {
      StackTrace? stackTrace;
      if (errorLogMessage is TypeError) {
        TypeError e = errorLogMessage;
        stackTrace = e.stackTrace;
      } else {
        stackTrace = StackTrace.current;
      }

      print("\x1B[31mQAPPError: $errorLogMessage at:\n $stackTrace\x1B[0m");
    } else {
      print("\x1B[31mQAPPError: $errorLogMessage\x1B[0m");
    }
  }

  static void warning(dynamic errorLogMessage,
      {bool withToast = false, bool withStackTrace = true}) {
    if (Utils.isInReleaseMode) return;
    if (errorLogMessage == null) return;

    if (withStackTrace) {
      StackTrace? stackTrace;
      if (errorLogMessage is TypeError) {
        TypeError e = errorLogMessage;
        stackTrace = e.stackTrace;
      } else {
        stackTrace = StackTrace.current;
      }
      print(
          "\x1b[33mPumbaApplicationWarning: $errorLogMessage at:\n $stackTrace\x1B[0m");
    } else {
      print("\x1b[33mPumbaApplicationWarning: $errorLogMessage\x1B[0m");
    }
  }

  /// Returns the stack trace
  static String log(dynamic logMessage, {withStackTrace = true}) {
    if (!Utils.isInDebugMode) return "";
    String message = logMessage?.toString() ?? "<null>";
    String stackTrace = StackTrace.current.toString();
    if (withStackTrace) {
      String line = stackTrace.split('\n')[1];
      line = line.replaceAll("flutter: #1", "");
      print("\x1B[32mPumbaApplication: $line: $message\x1B[0m");
    } else {
      print("\x1B[32mPumbaApplication: $message\x1B[0m");
    }

    return stackTrace;
  }
}
