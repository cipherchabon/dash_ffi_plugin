use std::env;

fn main() {
    let cargo_manifest_dir = env::var("CARGO_MANIFEST_DIR").unwrap();

    let config = cbindgen::Config {
        language: cbindgen::Language::C,
        braces: cbindgen::Braces::SameLine,
        style: cbindgen::Style::Both,
        ..Default::default()
    };

    cbindgen::Builder::new()
        .with_crate(cargo_manifest_dir)
        .with_config(config)
        .with_no_includes()
        .generate()
        .expect("Unable to generate bindings")
        .write_to_file("ferris_ffi_plugin.h");
}
