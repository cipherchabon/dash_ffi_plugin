use std::ffi::c_ushort;

#[no_mangle]
pub extern "C" fn get_max_c_ushort() -> c_ushort {
    c_ushort::max_value()
}

#[no_mangle]
pub extern "C" fn get_min_c_ushort() -> c_ushort {
    c_ushort::min_value()
}
