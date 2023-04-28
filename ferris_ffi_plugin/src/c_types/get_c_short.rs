use std::ffi::c_short;

#[no_mangle]
pub extern "C" fn get_max_c_short() -> c_short {
    c_short::max_value()
}

#[no_mangle]
pub extern "C" fn get_min_c_short() -> c_short {
    c_short::min_value()
}
