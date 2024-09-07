import 'dart:developer';

import 'package:mc_errors_sync/src/models/mc_error_sync_keys.dart';
import 'package:rxdart/rxdart.dart';

import 'models/uploaded_error.dart';

class McErrorsSyncService {
  static void Function() onListen() => () => log('onListen', level: 2, name: McErrorSyncKeys.name);

  static void Function() onCancel() => () => log('onCancel', level: 2, name: McErrorSyncKeys.name);

  static Stream<UploadedError> get getErrorsPayload => _errorsSubject.asBroadcastStream();

  static final BehaviorSubject<UploadedError> _errorsSubject =
      BehaviorSubject<UploadedError>(onListen: onListen, onCancel: onCancel);

  McErrorsSyncService();

  void addError(UploadedError data) {
    log(
      '🐞🐞😜 addError: \n${data.runtimeType} ==>  ',
      error: data.error,
      sequenceNumber: 1,
      stackTrace: data.stackTrace,
      level: 1,
      name: McErrorSyncKeys.name,
    );
    _errorsSubject.sink.add(data);
  }
}
