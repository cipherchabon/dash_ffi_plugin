import 'dart:ffi';

/// Converts a pointer to an array of unsigned 8-bit integers (Uint8) to a list
/// of integers, where each integer represents a byte. [ptr] is the pointer to
/// the Uint8 array, and [length] is the number of elements in the array.
List<int> convertPointerToBytes(Pointer<Uint8> ptr, int length) {
  List<int> bytes = [];
  for (int i = 0; i < length; i++) {
    bytes.add(ptr.elementAt(i).value);
  }
  return bytes;
}

/// Converts a list of integers representing bytes to a BigInt. [bytes] is the
/// list of integers, where each integer is a byte value. The function combines
/// the bytes in little-endian order to form the BigInt.
BigInt bytesToBigIntLittleEndian(List<int> bytes) {
  BigInt result = BigInt.from(0);
  int shiftAmount = 0;
  for (int byte in bytes) {
    BigInt shiftedByte = BigInt.from(byte) << shiftAmount;
    result |= shiftedByte;
    shiftAmount += 8;
  }
  return result;
}

/// Converts a list of integers representing bytes to a BigInt using big-endian order.
/// [bytes] is the list of integers, where each integer is a byte value.
/// The function combines the bytes in big-endian order to form the BigInt.
BigInt bytesToBigIntBigEndian(List<int> bytes) {
  BigInt result = BigInt.from(0);
  for (int byte in bytes) {
    result = (result << 8) | BigInt.from(byte);
  }
  return result;
}
