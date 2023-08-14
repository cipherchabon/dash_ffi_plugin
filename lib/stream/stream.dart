import 'dart:async';
import 'dart:ffi';
import 'dart:isolate';

import 'package:dash_ffi_plugin/bindings.dart';

class Streamer {
  final _controller = StreamController<String>();

  Stream<String> call() {
    final receivePort = ReceivePort();
    receivePort.listen((message) {
      _controller.add(message as String);
    });

    final port = receivePort.sendPort.nativePort;
    bindings.start_rust_code(port);

    return _controller.stream;
  }

  void dispose() {
    _controller.close();
  }
}
