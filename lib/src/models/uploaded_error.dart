import 'package:dio/dio.dart';
import 'package:mc_errors_sync/src/models/mc_error_sync_keys.dart';

class UploadedError {
  static const String _defaultMsg = McErrorSyncKeys.defaultMessage;
  final String reason;
  final Object error;
  final StackTrace? stackTrace;
  final bool isFatal;

  bool get isStringError {
    return stackTrace == null && error == Object() && isFatal == false;
  }

  const UploadedError._(this.reason, this.error, this.stackTrace, this.isFatal);

  factory UploadedError.formString(String reason) {
    return UploadedError._(reason, Object(), null, false);
  }

  factory UploadedError.by(Object error,
      [StackTrace? stackTrace, String? reason, bool isCriticalError = false]) {
    return UploadedError._(reason ?? _defaultMsg, error, stackTrace, isCriticalError);
  }

  factory UploadedError.fromAppDio(DioException dioError) {
    String reason = 'Error(${dioError.response?.statusCode ?? 0})';
    reason += dioError.message ?? _defaultMsg;
    final Object error = dioError.error ?? dioError.message ?? McErrorSyncKeys.fallbackMessage;
    final StackTrace stackTrace = dioError.stackTrace;
    final bool isFatal = (dioError.response?.statusCode ?? 0) >= 500;
    return UploadedError._(reason, error, stackTrace, isFatal);
  }

  @override
  String toString() {
    return '''Upload Error Class:
              Reason: $reason
              Error: ${error.toString()}
              Stack Trace: ${stackTrace.toString()}
              Is Fatal: $isFatal''';
  }
}
