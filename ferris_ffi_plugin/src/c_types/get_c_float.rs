use std::ffi::c_float;

#[no_mangle]
pub extern "C" fn get_default_c_float() -> c_float {
    c_float::default()
}
