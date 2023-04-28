import 'dart:ffi';

import 'package:dash_ffi_plugin/bindings.dart';
import 'package:ffi/ffi.dart';

import '../utils.dart';

String getCStr() {
  final result = bindings.get_c_str();
  final dartStr = result.cast<Utf8>().toDartString();
  bindings.free_c_char_ptr(result);
  return dartStr;
}

Response getResponse() {
  final nativeResponse = bindings.get_response();
  final code = nativeResponse.code;
  final body = nativeResponse.body.cast<Utf8>().toDartString();
  return Response(code, body);
}

class Response {
  final int code;
  final String body;

  const Response(
    this.code,
    this.body,
  );
}

Pointer<Char> getHelloWorldWithName(String name) {
  final namePtr = name.toNativeUtf8();
  final result = bindings.get_hello_world_with_name(namePtr.cast());
  calloc.free(namePtr);
  return result;
}

double getDefaultDouble() => bindings.get_default_c_double();
double getDefaultFloat() => bindings.get_default_c_float();

int getMaxChar() => bindings.get_max_c_char();
int getMinChar() => bindings.get_min_c_char();
int getMaxInt() => bindings.get_max_c_int();
int getMinInt() => bindings.get_min_c_int();
int getMaxLong() => bindings.get_max_c_long();
int getMinLong() => bindings.get_min_c_long();
int getMaxLonglong() => bindings.get_max_c_longlong();
int getMinLonglong() => bindings.get_min_c_longlong();
int getMaxSchar() => bindings.get_max_c_schar();
int getMinSchar() => bindings.get_min_c_schar();
int getMaxShort() => bindings.get_max_c_short();
int getMinShort() => bindings.get_min_c_short();
int getMaxUchar() => bindings.get_max_c_uchar();
int getMinUchar() => bindings.get_min_c_uchar();
int getMaxUint() => bindings.get_max_c_uint();
int getMinUint() => bindings.get_min_c_uint();
int getMinUlong() => bindings.get_min_c_ulong();
int getMinUlonglong() => bindings.get_min_c_ulonglong();
int getMaxUshort() => bindings.get_max_c_ushort();
int getMinUshort() => bindings.get_min_c_ushort();

/// Returns the maximum value of a C unsigned long as a Dart BigInt.
BigInt getMaxUlong() {
  final byteArray = bindings.get_max_c_ulong_as_bytes();
  List<int> bytes = convertPointerToBytes(
    byteArray.data as Pointer<Uint8>,
    byteArray.len,
  );
  bindings.free_byte_array(byteArray);
  return bytesToBigIntBigEndian(bytes);
}

BigInt getMaxUlonglong() {
  final ptrChar = bindings.get_max_c_ulonglong_as_string();
  final dartStr = ptrChar.cast<Utf8>().toDartString();
  bindings.free_c_char_ptr(ptrChar);
  return BigInt.parse(dartStr);
}
