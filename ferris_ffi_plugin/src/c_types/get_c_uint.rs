use std::ffi::c_uint;

#[no_mangle]
pub extern "C" fn get_max_c_uint() -> c_uint {
    c_uint::max_value()
}

#[no_mangle]
pub extern "C" fn get_min_c_uint() -> c_uint {
    c_uint::min_value()
}
