import 'package:dash_ffi_plugin/dash_ffi_plugin.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('test name', () {
    final res = sum(2, 5);
    expect(res, 7);
  });
}
