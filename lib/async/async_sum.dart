import 'dart:async';
import 'dart:isolate';

import '../bindings.dart';
import 'async_command_executor.dart';

/// Sum two numbers asynchronously
Future<int> sumAsync(int a, int b) async {
  final request = SumRequest(commandExecutor.nextRequestId, a, b);
  final response = await commandExecutor.callAsyncCommand<SumResponse>(request);
  return response.result;
}

/// SumRequest class to hold the sum request
class SumRequest extends AsyncCommand {
  final int a;
  final int b;

  const SumRequest(super.id, this.a, this.b);

  // Execute the sum operation and send the response back
  @override
  void execute(SendPort sendPort) {
    final int result = bindings.sum_long_running(a, b);
    final response = SumResponse(id, result);
    sendPort.send(response);
  }
}

/// SumResponse class to hold the sum response
class SumResponse extends AsyncResponse {
  final int result;

  const SumResponse(
    super.id,
    this.result,
  );
}
