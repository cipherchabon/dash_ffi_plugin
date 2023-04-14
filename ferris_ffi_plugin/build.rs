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
        .write_to_file("ferris_ffi_plugin.h");
}
