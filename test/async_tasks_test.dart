import 'package:dash_ffi_plugin/async/async_sum.dart';
import 'package:flutter_test/flutter_test.dart';

void main() async {
  test('sum async', () async {
    final res = sumAsync(2, 2);
    expect(res, completion(4));
  });
}
