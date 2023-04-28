use std::ffi::c_uchar;

#[no_mangle]
pub extern "C" fn get_max_c_uchar() -> c_uchar {
    c_uchar::max_value()
}

#[no_mangle]
pub extern "C" fn get_min_c_uchar() -> c_uchar {
    c_uchar::min_value()
}
