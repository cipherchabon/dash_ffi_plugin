import 'package:dash_ffi_plugin/sync/sync_tasks.dart';
import 'package:ffi/ffi.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('getCStr', () {
    expect(getCStr(), 'Hello, world!');
  });

  test('getResponse', () {
    final response = getResponse();
    expect(response.code, 200);
    expect(response.body, 'Hello, world!');
  });

  test('getHelloWorldWithName', () {
    expect(
      getHelloWorldWithName('Dash').cast<Utf8>().toDartString(),
      'Hello, world! Dash',
    );
  });

  test('getDefaultDouble', () {
    expect(getDefaultDouble(), 0.0);
  });

  test('getDefaultFloat', () {
    expect(getDefaultFloat(), 0.0);
  });

  test('getMaxChar', () {
    expect(getMaxChar(), 127);
  });

  test('getMinChar', () {
    expect(getMinChar(), -128);
  });

  test('getMaxInt', () {
    expect(getMaxInt(), 2147483647);
  });

  test('getMinInt', () {
    expect(getMinInt(), -2147483648);
  });

  test('getMaxLong', () {
    expect(getMaxLong(), 9223372036854775807);
  });

  test('getMinLong', () {
    expect(getMinLong(), -9223372036854775808);
  });

  test('getMaxLonglong', () {
    expect(getMaxLonglong(), 9223372036854775807);
  });

  test('getMinLonglong', () {
    expect(getMinLonglong(), -9223372036854775808);
  });

  test('getMaxSchar', () {
    expect(getMaxSchar(), 127);
  });

  test('getMinSchar', () {
    expect(getMinSchar(), -128);
  });

  test('getMaxShort', () {
    expect(getMaxShort(), 32767);
  });

  test('getMinShort', () {
    expect(getMinShort(), -32768);
  });

  test('getMaxUchar', () {
    expect(getMaxUchar(), 255);
  });

  test('getMinUchar', () {
    expect(getMinUchar(), 0);
  });

  test('getMaxUint', () {
    expect(getMaxUint(), 4294967295);
  });

  test('getMinUint', () {
    expect(getMinUint(), 0);
  });

  test('getMaxUlong', () {
    expect(
      getMaxUlong(),
      BigInt.parse('18446744073709551615'),
    );
  });

  test('getMinUlong', () {
    expect(getMinUlong(), 0);
  });

  test('getMaxUlonglong', () {
    expect(
      getMaxUlonglong(),
      BigInt.parse('18446744073709551615'),
    );
  });

  test('getMinUlonglong', () {
    expect(getMinUlonglong(), 0);
  });

  test('getMaxUshort', () {
    expect(getMaxUshort(), 65535);
  });

  test('getMinUshort', () {
    expect(getMinUshort(), 0);
  });
}
