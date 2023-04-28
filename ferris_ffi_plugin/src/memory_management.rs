use std::{
    alloc::{dealloc, Layout},
    ffi::{c_char, CString},
};

use std::mem;

use crate::util_types::ByteArray;

/// # Safety
/// It is the caller's responsibility to ensure that the pointer is valid.
#[no_mangle]
pub unsafe extern "C" fn free_c_char_ptr(ptr: *mut c_char) {
    if !ptr.is_null() {
        let _ = CString::from_raw(ptr);
    }
}

/// # Safety
/// It is the caller's responsibility to ensure that the pointer is valid.
#[no_mangle]
pub unsafe extern "C" fn free_byte_array(arr: ByteArray) {
    let layout = Layout::from_size_align(arr.len, mem::align_of::<u8>()).unwrap();
    dealloc(arr.data as *mut u8, layout);
}
