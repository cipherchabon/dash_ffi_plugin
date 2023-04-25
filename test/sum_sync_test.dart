// ignore_for_file: avoid_print

import 'package:dash_ffi_plugin/sum_sync.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('test name', () {
    //
    try {
      final suma = sum(1, 3);
      print(suma);
    } catch (e) {
      print(e);
    }
  });
}
