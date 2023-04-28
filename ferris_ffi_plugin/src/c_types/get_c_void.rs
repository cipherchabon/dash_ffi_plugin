use std::ffi::c_void;

#[no_mangle]
pub extern "C" fn get_c_void() -> *const c_void {
    std::ptr::null()
}
