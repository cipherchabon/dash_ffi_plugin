use std::ffi::c_long;

#[no_mangle]
pub extern "C" fn get_max_c_long() -> c_long {
    c_long::max_value()
}

#[no_mangle]
pub extern "C" fn get_min_c_long() -> c_long {
    c_long::min_value()
}
