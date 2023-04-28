use std::ffi::c_int;

#[no_mangle]
pub extern "C" fn get_max_c_int() -> c_int {
    c_int::max_value()
}

#[no_mangle]
pub extern "C" fn get_min_c_int() -> c_int {
    c_int::min_value()
}
