/// The primary purpose of this code is to execute asynchronous commands using a
/// command design pattern and manage their communication via isolates. It
/// enables the execution of time-consuming tasks in the background without
/// blocking the main thread, allowing for efficient handling of concurrent
/// operations.

import 'dart:async';
import 'dart:isolate';

final commandExecutor = CommandExecutor();

/// Base class for async commands
abstract class AsyncCommand {
  final int id;

  const AsyncCommand(this.id);

  void execute(SendPort sendPort);
}

/// Base class for async responses
abstract class AsyncResponse {
  final int id;

  const AsyncResponse(this.id);
}

/// CommandExecutor class to execute async commands and manage their
/// communication via isolates It enables the execution of time-consuming tasks
/// in the background without blocking the main thread, allowing for efficient
/// handling of concurrent operations.
class CommandExecutor {
  int _nextRequestId = 0;
  int get nextRequestId => _nextRequestId;

  final Map<int, Completer<dynamic>> _requests = {};
  late Future<SendPort> _helperIsolateSendPort;

  CommandExecutor() {
    _helperIsolateSendPort = _initializeHelperIsolate();
  }

  /// Call an async command and return a future with the response The command is
  /// executed in a separate isolate and the response is sent back to the main
  /// isolate via a send port
  Future<T> callAsyncCommand<T extends AsyncResponse>(
    AsyncCommand command,
  ) async {
    final SendPort helperIsolateSendPort = await _helperIsolateSendPort;

    final int requestId = _nextRequestId++;
    final Completer<T> completer = Completer<T>();
    _requests[requestId] = completer;

    helperIsolateSendPort.send(command);

    return completer.future;
  }

  // Initialize the helper isolate and set up the message handling
  Future<SendPort> _initializeHelperIsolate() async {
    final completer = Completer<SendPort>();

    void handleIsolateMessage(dynamic data) {
      if (data is SendPort) {
        completer.complete(data);
        return;
      }
      if (data is AsyncResponse) {
        final Completer<dynamic> completer = _requests[data.id]!;
        _requests.remove(data.id);
        completer.complete(data);
        return;
      }
      throw UnsupportedError('Unsupported message type: ${data.runtimeType}');
    }

    final receivePort = ReceivePort()..listen(handleIsolateMessage);

    await Isolate.spawn((SendPort sendPort) async {
      final ReceivePort helperReceivePort = ReceivePort()
        ..listen((dynamic data) {
          if (data is AsyncCommand) {
            data.execute(sendPort);
            return;
          }
          throw UnsupportedError(
            'Unsupported message type: ${data.runtimeType}',
          );
        });

      sendPort.send(helperReceivePort.sendPort);
    }, receivePort.sendPort);

    return completer.future;
  }
}
