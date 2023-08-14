## A very short-lived native function.

For very short-lived functions, it is fine to call them on the main isolate. They will block the Dart execution while running the native function, so only do this for native functions which are guaranteed to be short-lived.

## A longer lived native function, which occupies the thread calling it.

Do not call these kind of native functions in the main isolate. They will block Dart execution. This will cause dropped frames in Flutter applications. Instead, call these native functions on a separate isolate.

Modify this to suit your own use case. Example use cases:
1. Reuse a single isolate for various different kinds of requests.
2. Use multiple helper isolates for parallel execution.