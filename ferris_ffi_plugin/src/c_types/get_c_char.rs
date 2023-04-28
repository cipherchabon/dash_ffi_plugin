use std::ffi::{c_char, CStr, CString};

#[no_mangle]
pub extern "C" fn get_max_c_char() -> c_char {
    c_char::max_value()
}

#[no_mangle]
pub extern "C" fn get_min_c_char() -> c_char {
    c_char::min_value()
}

#[no_mangle]
pub extern "C" fn get_c_str() -> *const c_char {
    let c_string = CString::new("Hello, world!").unwrap();
    let ptr = c_string.as_ptr();
    std::mem::forget(c_string); // Evita que se libere la memoria cuando `c_string` salga de su alcance
    ptr
}

/// # Safety
///
/// The `name` argument must be a valid, non-null pointer to a null-terminated C string.
/// It is the caller's responsibility to ensure that the pointer is valid.
/// Calling this function with an invalid or null pointer will result in undefined behavior.
#[no_mangle]
pub unsafe extern "C" fn get_hello_world_with_name(name: *const c_char) -> *mut c_char {
    let name_cstr = unsafe { CStr::from_ptr(name) };
    let name_str = name_cstr.to_str().unwrap();

    let hello_world = format!("Hello, world! {}", name_str);
    let c_string = CString::new(hello_world).unwrap();
    c_string.into_raw()
}
