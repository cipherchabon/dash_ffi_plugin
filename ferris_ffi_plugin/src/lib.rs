use std::ffi::c_int;
use std::thread;
use std::time::Duration;

#[no_mangle]
pub extern "C" fn sum(a: c_int, b: c_int) -> c_int {
    a + b
}

#[no_mangle]
pub extern "C" fn sum_long_running(a: c_int, b: c_int) -> c_int {
    // Simulate a long running task
    thread::sleep(Duration::from_millis(5000));
    a + b
}
