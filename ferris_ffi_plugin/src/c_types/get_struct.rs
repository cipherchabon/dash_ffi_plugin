use std::ffi::{c_char, CString};

#[repr(C)]
pub struct NativeResponse {
    pub code: u32,
    pub body: *const c_char,
}

#[no_mangle]
pub extern "C" fn get_response() -> NativeResponse {
    let c_string = CString::new("Hello, world!").unwrap();
    let ptr = c_string.as_ptr();
    std::mem::forget(c_string);

    NativeResponse {
        code: 200,
        body: ptr,
    }
}

/// # Safety
///
/// The `response` argument must be a valid, non-null pointer to a Response.
/// It is the caller's responsibility to ensure that the pointer is valid.
/// Calling this function with an invalid or null pointer will result in
/// undefined behavior.
///
/// Make sure not to use the pointer after it has been freed, as it will no
/// longer be valid.
#[no_mangle]
pub unsafe extern "C" fn free_response(response: *mut NativeResponse) {
    let response = unsafe { &mut *response };
    let _ = unsafe { CString::from_raw(response.body as *mut c_char) };
}
