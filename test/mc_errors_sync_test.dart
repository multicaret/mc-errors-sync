import 'package:flutter_test/flutter_test.dart';
import 'package:mc_errors_sync/src/base.dart';
import 'package:mc_errors_sync/src/mc_errors_sync_service.dart';
import 'package:mc_errors_sync/src/models/mc_error_sync_keys.dart';
import 'package:mc_errors_sync/src/models/uploaded_error.dart';

void main() {
  group('mc_errors_sync library tests', () {
    test('Push string and receive it in listener', () {
      McErrorsSyncService.getErrorsPayload.listen((UploadedError event) {
        expect(event, isNotNull);
      });
      McErrorSync.pushString(McErrorSyncKeys.defaultMessage);
    });
  });
}
