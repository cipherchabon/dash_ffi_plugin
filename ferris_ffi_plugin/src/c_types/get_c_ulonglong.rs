use std::alloc::{alloc, Layout};
use std::ffi::c_ulonglong;
use std::ffi::CString;
use std::mem;
use std::os::raw::c_char;

use crate::util_types::ByteArray;

// WARNING: This function should not be used from Dart, as the maximum value of
// ulonglong cannot be represented using Dart's int type. Please use the
// `get_max_c_ulonglong_as_bytes` function instead, which returns the maximum
// value as a byte array that can be safely converted to Dart's BigInt.
#[no_mangle]
pub extern "C" fn get_max_c_ulonglong() -> c_ulonglong {
    c_ulonglong::max_value()
}

#[no_mangle]
pub extern "C" fn get_min_c_ulonglong() -> c_ulonglong {
    c_ulonglong::min_value()
}

///// AS STRING /////

/// # Safety
/// The returned pointer must be freed with `free_c_char_ptr`.
#[no_mangle]
pub extern "C" fn get_max_c_ulonglong_as_string() -> *mut c_char {
    let max_value = c_ulonglong::max_value();
    let c_string = CString::new(max_value.to_string()).unwrap();
    c_string.into_raw()
}

//// AS BYTES ////

#[no_mangle]
pub extern "C" fn get_max_c_ulonglong_as_bytes() -> ByteArray {
    let max_value = c_ulonglong::max_value();
    // Convert the value to a big-endian byte array.
    let bytes = max_value.to_be_bytes();

    // Allocate memory for the bytes
    // SAFETY: We just allocated this memory, so it is safe to use.
    let layout = Layout::from_size_align(mem::size_of::<[u8; 8]>(), mem::align_of::<u8>()).unwrap();
    let data = unsafe { alloc(layout) as *mut u8 };
    if data.is_null() {
        return ByteArray {
            data: std::ptr::null(),
            len: 0,
        };
    }
    // Copy the byte array to the allocated memory.
    unsafe {
        std::ptr::copy_nonoverlapping(bytes.as_ptr(), data, mem::size_of::<[u8; 8]>());
    }

    ByteArray {
        data,
        len: mem::size_of::<[u8; 8]>(),
    }
}
