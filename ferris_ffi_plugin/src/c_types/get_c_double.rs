use std::ffi::c_double;

#[no_mangle]
pub extern "C" fn get_default_c_double() -> c_double {
    c_double::default()
}
