use std::ffi::c_longlong;

#[no_mangle]
pub extern "C" fn get_max_c_longlong() -> c_longlong {
    c_longlong::max_value()
}

#[no_mangle]
pub extern "C" fn get_min_c_longlong() -> c_longlong {
    c_longlong::min_value()
}
