use std::ffi::c_schar;

#[no_mangle]
pub extern "C" fn get_max_c_schar() -> c_schar {
    c_schar::max_value()
}

#[no_mangle]
pub extern "C" fn get_min_c_schar() -> c_schar {
    c_schar::min_value()
}
