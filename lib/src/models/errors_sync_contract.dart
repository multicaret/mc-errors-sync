abstract class McErrorsSyncContract {
  Future<void> pushErrorMessage(String message);

  Future<void> pushError(String reason, Object error, {StackTrace? stackTrace, bool fatal = false});
}
