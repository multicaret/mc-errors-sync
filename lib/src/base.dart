import 'package:dio/dio.dart';
import 'package:mc_errors_sync/src/models/uploaded_error.dart';

import 'mc_errors_sync_service.dart';

class McErrorSync {
  static pushString(String reason) {
    final UploadedError uploadedError = UploadedError.formString(reason);
    McErrorsSyncService().addError(uploadedError);
  }

  static push(Object error,
      [StackTrace? stackTrace, String? reason, bool isCriticalError = false]) {
    final UploadedError uploadedError =
        UploadedError.by(error, stackTrace, reason, isCriticalError);
    McErrorsSyncService().addError(uploadedError);
  }

  static pushDioError(DioException dioError) {
    final UploadedError uploadedError = UploadedError.fromAppDio(dioError);
    McErrorsSyncService().addError(uploadedError);
  }
}
