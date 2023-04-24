import 'dart:ffi';
import 'dart:io';

import 'dash_ffi_plugin_bindings_generated.dart';

const String _libName = 'libferris_ffi_plugin';

/// The bindings to the native functions in [_dylib].
final bindings = DashFfiPluginBindings(_dylib);

/// The dynamic library in which the symbols for [DashFfiPluginBindings] can be found.
final DynamicLibrary _dylib = () {
  if (Platform.isMacOS) {
    // if (kDebugMode) {
    //   final currentPath = Directory.current.path;
    //   print(currentPath);
    //   return DynamicLibrary.open('$currentPath/macos/$_libName.dylib');
    // }
    return DynamicLibrary.open('$_libName.dylib');
  } else {
    throw UnsupportedError('Unknown platform: ${Platform.operatingSystem}');
  }
}();
