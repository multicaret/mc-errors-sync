import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'mc_errors_sync_service.dart';
import 'models/errors_sync_contract.dart';
import 'models/uploaded_error.dart';

class McErrorsUploaderObserver extends ProviderObserver {
  McErrorsUploaderObserver(Provider<McErrorsSyncContract> provider) {
    McErrorsSyncService.getErrorsPayload.asBroadcastStream().listen((UploadedError event) {
      final McErrorsSyncContract service = ProviderContainer().read(provider);
      if (event.isStringError) {
        service.pushErrorMessage(event.reason);
      } else {
        service.pushError(
          event.reason,
          event.error,
          stackTrace: event.stackTrace,
          fatal: event.isFatal,
        );
      }
    });
  }
}
