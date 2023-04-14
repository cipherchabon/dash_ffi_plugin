# Using FFI in a Flutter plugin with Rust

This guide will walk you through the process of creating a Flutter plugin that uses Rust code via FFI (Foreign Function Interface). It consists of several steps:

## Requirements:

- Flutter 2.5.0 or later
- Rust 1.55.0 or later
- cargo-make 0.35.6 or later

> Note: When you see `<flutter_lib_name>`, replace it with the name of your Flutter library. When you see `<rust_lib_name>`, replace it with the name of your Rust library. 

## Create a new Flutter plugin: 
Use the `flutter create` command with the appropriate flags to create a new plugin project. This will generate the necessary files and directories for the plugin, including platform-specific code.
```bash
$ flutter create -t plugin_ffi --platforms macos <flutter_plugin_name>
$ cd <flutter_plugin_name>
```

## Create a new Rust library: 
With the `cargo new` command, create a new Rust library project. This will generate a new directory with the Rust library's source code and configuration files.
```bash
$ cargo new --lib <rust_lib_name>
$ cd <rust_lib_name>
$ cargo check
```

## Configure the Rust library: 
Create a `build.rs` file to configure the Rust library for FFI compatibility. You'll need to use the `cbindgen` crate to generate the appropriate C-compatible header files. Also, modify the `Cargo.toml` file to include the necessary build settings and dependencies.

Create build.rs:

```rust
// build.rs
use cbindgen;
use std::env;

fn main() {
    let cargo_manifest_dir = env::var("CARGO_MANIFEST_DIR").unwrap();

    let mut config = cbindgen::Config::default();

    config.language = cbindgen::Language::C;
    config.braces = cbindgen::Braces::SameLine;
    config.cpp_compat = true;
    config.style = cbindgen::Style::Both;

    cbindgen::Builder::new()
        .with_crate(&cargo_manifest_dir)
        .with_config(config)
        .with_no_includes()
        .generate()
        .expect("Unable to generate bindings")
        .write_to_file("<rust_lib_name>");
}
```

Edit Cargo.toml:

```toml
[package]
name = "<rust_lib_name>"
version = "0.1.0"
edition = "2021"
build = "build.rs"

[dependencies]

[lib]
crate-type = ["cdylib"]

[build-dependencies]
cbindgen = "0.24.3"
```

## Implement Rust functions: 
Write the Rust code for the functions you want to expose to the Flutter plugin. Make sure to use the #[no_mangle] attribute and the `extern "C"` keyword for each function. This ensures the correct binary code is generated for FFI compatibility. Compile the Rust code with `cargo build --release`.

Edit `<rust_lib_name>/src/lib.rs`:

```rust
use std::ffi::c_int;
use std::thread;
use std::time::Duration;

#[no_mangle]
pub extern "C" fn sum(a: c_int, b: c_int) -> c_int {
    a + b
}

#[no_mangle]
pub extern "C" fn sum_long_running(a: c_int, b: c_int) -> c_int {
    // Simulate a long running task
    thread::sleep(Duration::from_millis(5000));
    a + b
}
```

```bash
$ cargo build --release
```

Generate FFI bindings: Update the `ffigen.yaml` file to point to the Rust library's header file, and then use the `ffigen` command to generate the Dart FFI bindings.

Edit `ffigen.yaml`:

```yaml
headers:
  entry-points:
    - "<rust_lib_name>/<rust_lib_name>.h"
```

```bash
$ cd ..
$ flutter pub run ffigen --config ffigen.yaml
```

## Configure platform-specific settings: 
For each platform that the plugin supports, configure the platform-specific settings to include the compiled Rust library. This may involve updating the platform-specific configuration files and copying the compiled Rust library to the appropriate directories.

### MacOS:

Remove `macos/Classes/<flutter_lib_name>.c`.

```bash
$ rm macos/Classes/<flutter_lib_name>.c
```

Copy `<rust_lib_name>/target/release/lib<rust_lib_name>.dylib` to `macos/`.

```bash
$ cp <rust_lib_name>/target/release/lib<rust_lib_name>.dylib macos/
```

Edit `macos/<flutter_lib_name>.podspec` to include the Rust library in the podspec's vendored_libraries property.

```ruby
Pod::Spec.new do |s|
  # ... other config
  s.vendored_libraries = 'lib<rust_lib_name>.dylib'
end
```

## Update the Flutter plugin: 
Modify the plugin's Dart code to use the generated FFI bindings and the Rust library. Make sure to specify the correct dynamic library name for each platform.

Edit `lib/<flutter_ffi_plugin>.dart`

```dart
const String _libName = 'lib<rust_lib_name>';

/// The dynamic library in which the symbols for [DashFfiPluginBindings] can be found.
final DynamicLibrary _dylib = () {
  if (Platform.isMacOS) {
    return DynamicLibrary.open('$_libName.dylib');
  } else {
    throw UnsupportedError('Unknown platform: ${Platform.operatingSystem}');
  }
}();
```

## Automate the build process: 
Create a `Makefile.toml` file in the Rust plugin's root directory. This file contains instructions for compiling the Rust code and copying the resulting library to the corresponding directories in the Flutter application. Use `cargo-make` to automate the build process.

By following these steps, you'll be able to create a Flutter plugin that uses Rust code via FFI, allowing you to leverage the performance and safety features of Rust in your Flutter applications.